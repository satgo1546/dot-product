#include <stddef.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define _UNICODE
#define UNICODE

#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#ifdef _MSC_VER
	#pragma comment(lib, "user32")
	#pragma comment(lib, "gdi32")
#endif

#define szTitle L"CPBox"
#define szWindowClass L"cpbox"
#define dwWindowStyle (WS_TILED | WS_CAPTION | WS_SYSMENU | WS_MINIMIZEBOX)
HINSTANCE hInst;
HWND hWnd;
HFONT ui_font;
HWND hWnd_boxes[4];

LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam) {
	switch (message) {
	case WM_COMMAND:
		if (lParam) {
			if (HIWORD(wParam) == BN_CLICKED) {
				if (on_keydown) on_keydown(LOWORD(wParam));
			}
		} else {
			switch (wParam) {
			case 1:
				break;
			default:
				MessageBox(hWnd, L"Unknown menu identifier.", szTitle, MB_ICONSTOP);
			}
		}
		break;
	case WM_DESTROY:
		PostQuitMessage(0);
		break;
	default:
		return DefWindowProc(hWnd, message, wParam, lParam);
	}
	return 0;
}

int APIENTRY WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow) {
	int i;
	WNDCLASSEXW wcex;

	wcex.cbSize = sizeof(WNDCLASSEX);

	wcex.style          = CS_HREDRAW | CS_VREDRAW;
	wcex.lpfnWndProc    = WndProc;
	wcex.cbClsExtra     = 0;
	wcex.cbWndExtra     = 0;
	wcex.hInstance      = hInstance;
	wcex.hIcon          = LoadIcon(hInstance, MAKEINTRESOURCE(1));
	wcex.hCursor        = LoadCursor(NULL, IDC_ARROW);
	wcex.hbrBackground  = (HBRUSH) (COLOR_3DFACE + 1);
	wcex.lpszMenuName   = NULL;
	wcex.lpszClassName  = szWindowClass;
	wcex.hIconSm        = NULL;

	RegisterClassExW(&wcex);

	hInst = hInstance;

	ui_font = GetStockObject(DEFAULT_GUI_FONT);
	hWnd = CreateWindowW(szWindowClass, szTitle, dwWindowStyle, CW_USEDEFAULT, 0, CW_USEDEFAULT, 0, NULL, NULL, hInstance, NULL);
	if (!hWnd) return FALSE;

	for (i = 0; i < 4; i++) {
		DWORD style = WS_CHILD | WS_VISIBLE | WS_TABSTOP
			| ES_MULTILINE | ES_WANTRETURN | ES_AUTOVSCROLL;
		if (i & 1) style |= ES_READONLY;
		hWnd_boxes[i] = CreateWindowW(
			L"EDIT", L"", style,
			(i & 1) ? 128 : 0, (i >> 1) ? 64 : 0, 128, 64,
			hWnd, (HMENU) i, hInstance, NULL
		);
		if (style & ES_READONLY) {
			//SendMessage(hWnd_boxes[i], EM_SETBKGNDCOLOR, 0, GetSysColor(COLOR_3DFACE));
		}
		SendMessage(hWnd_boxes[i], WM_SETFONT, (WPARAM) ui_font, false);
	}

	ShowWindow(hWnd, nCmdShow);
	UpdateWindow(hWnd);

	MSG msg;

	while (GetMessage(&msg, NULL, 0, 0)) if (!IsDialogMessage(hWnd, &msg)) {
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}

	return (int) msg.wParam;
}
