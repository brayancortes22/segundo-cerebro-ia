---
name: web-performance-optimization
description: Measure and improve web loading, interaction, rendering, bundle size, memory, API latency, and Core Web Vitals. Use when pages are slow, an interaction feels delayed, a bundle is growing, or a performance budget is missed.
metadata:
  version: "1.0.0"
  reviewed: "2026-10-04"
---
# Web performance optimization

## Diagnose

- Confirm routes, user journey, device/network profile, production environment, and the desired metric or budget.
- Establish a reproducible production-like baseline. Separate lab data from field data and record browser, device, cache, region, and sample size.
- Inspect LCP, INP, CLS, transfer size, JavaScript execution, rendering, API/database latency, memory, and third-party scripts as relevant.
- Use browser performance tools, tracing, bundle analysis, and server telemetry to identify the constraint before changing code.

## Improve the dominant cost

- Reduce critical-path work and unnecessary client JavaScript. Use server rendering or streaming only where the framework and product flow benefit.
- Optimize image/font formats, dimensions, loading priority, caching, compression, and cache invalidation.
- Avoid network waterfalls; parallelize independent requests and remove redundant server-to-server hops.
- Use code splitting and lazy loading for noncritical routes/features; do not defer content required for the first meaningful view.
- Check long tasks and interaction handlers. Move expensive work off the main thread where appropriate, with cancellation and lifecycle management.
- Review database queries, indexes, payload size, CDN behavior, and third-party scripts when telemetry points there.
- Preserve correctness, accessibility, freshness, privacy, and error recovery while changing caches or rendering strategy.

## Validate

- Compare the same route and conditions before and after. Report metric distribution, environment, and data source.
- Verify cache hit/miss and invalidation behavior, narrow/mobile layouts, slow network, and errors.
- Do not claim a field Core Web Vitals improvement from one local Lighthouse score.

## References

- [Next.js production checklist](https://nextjs.org/docs/app/guides/production-checklist) for Next.js App Router projects.
- [web.dev — Web Vitals](https://web.dev/articles/vitals)
- [Chrome DevTools Performance](https://developer.chrome.com/docs/devtools/performance)
