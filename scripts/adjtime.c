#include <windows.h>
#include <strsafe.h>

void ErrorExit(LPTSTR lpszFunction) {
	// Retrieve the system error message for the last-error code

	LPVOID lpMsgBuf;
	LPVOID lpDisplayBuf;
	DWORD dw = GetLastError();

	FormatMessage(
		FORMAT_MESSAGE_ALLOCATE_BUFFER |
		FORMAT_MESSAGE_FROM_SYSTEM |
		FORMAT_MESSAGE_IGNORE_INSERTS,
		NULL,
		dw,
		MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
		(LPTSTR) &lpMsgBuf,
		0, NULL
	);

	// Display the error message and exit the process

	lpDisplayBuf = (LPVOID) LocalAlloc(
		LMEM_ZEROINIT,
		(lstrlen((LPCTSTR) lpMsgBuf) + lstrlen((LPCTSTR) lpszFunction) + 40) * sizeof(TCHAR)
	);
	StringCchPrintf(
		(LPTSTR) lpDisplayBuf,
		LocalSize(lpDisplayBuf) / sizeof(TCHAR),
		TEXT("%s() => %d:\r\n%s"),
		lpszFunction, dw, lpMsgBuf
	);
	MessageBox(NULL, (LPCTSTR) lpDisplayBuf, TEXT("ADJTIME.EXE"), MB_ICONERROR);

	LocalFree(lpMsgBuf);
	LocalFree(lpDisplayBuf);
	ExitProcess(dw);
}

int main(int argc, char** argv) {
	ULARGE_INTEGER a;
	long long d;
	FILETIME ft;
	SYSTEMTIME st;
	if (argc != 2) {
		printf("Usage:\n\t%s <adjustment/100 nanosecond>\n", argv[0]);
		return 1;
	}
	if (sscanf(argv[1], "%lld", &d) != 1) {
		fprintf(stderr, "<adjustment> should be an integer.\n");
		return 1;
	}
	GetSystemTimeAsFileTime(&ft);
	a.LowPart = ft.dwLowDateTime;
	a.HighPart = ft.dwHighDateTime;
	a.QuadPart += (ULONGLONG) d;
	ft.dwLowDateTime = a.LowPart;
	ft.dwHighDateTime = a.HighPart;
	if (!FileTimeToSystemTime(&ft, &st)) ErrorExit(TEXT("FileTimeToSystemTime"));
	if (!SetSystemTime(&st)) ErrorExit(TEXT("SetSystemTime"));
	return 0;
}
