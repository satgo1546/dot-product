// https://github.com/vitest-dev/vitest/blob/v5.0.0-beta.1/scripts/update-contributors.ts

import { promises as fs } from 'node:fs'

async function fetchContributors(page = 1) {
  const collaborators: string[] = []
  const data = await (await fetch(`https://api.github.com/repos/${owner}/${repo}/contributors?per_page=100&page=${page}`, {
    headers: {
      'Content-Type': 'application/json',
    },
  })).json() || []
  collaborators.push(...data.map(i => i.login))
  if (data.length === 100) {
    collaborators.push(...(await fetchContributors(page + 1)))
  }
  return collaborators.filter(name => !name.includes('[bot]'))
}

async function generate() {
  console.log(JSON.stringify(await fetchContributors(), null, 2))
}

generate()
