(async () => {
  const PATH = "/version"
  const TOTAL_REQUESTS = 1000
  const fetchUrl = `http://localhost:3000${PATH}`

  const start = performance.now()
  for (let i = 0; i < TOTAL_REQUESTS; i++) {
    await fetch(fetchUrl)
  }
  const end = performance.now()

  console.log(
    `The benchmark has been finished.
      - Total requests: ${TOTAL_REQUESTS}
      - Path: ${PATH}
    
      - Total time (milliseconds): ${(end - start)}ms
      - Average time (milliseconds): ${(end - start) / TOTAL_REQUESTS}ms
    `)
})()