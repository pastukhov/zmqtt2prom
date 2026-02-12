# Repository Guidelines

## Project Structure & Module Organization
This repository is a Swift Package executable.

- `Sources/mqtt2prom/`: application code.
- `Sources/mqtt2prom/Models/`: MQTT/Zigbee domain models (`Device`, `Expose`, etc.).
- `Sources/mqtt2prom/Services/`: MQTT client, discovery, metrics, and HTTP controller logic.
- `Tests/zmqtt2promTests/`: XCTest suite for models/config/flattening behavior.
- `.github/workflows/`: CI and release automation.
- Runtime/container assets: `Dockerfile`, `docker-compose.yml`.

## Build, Test, and Development Commands
Use Swift 6.1.x (CI runs `6.1.2`).

- `swift build`: debug build for local iteration.
- `swift build -c release`: production-style build (matches CI).
- `swift test`: run XCTest suite.
- `swift run zmqtt2prom --help`: inspect CLI options.
- `swift run zmqtt2prom --mqtt-host localhost --log-level info`: run locally.
- `docker compose up -d`: start containerized service using repo compose file.

## Coding Style & Naming Conventions
- Formatting is governed by `.swift-format`.
- Use 2-space indentation and keep line length within 140 chars.
- Follow Swift naming conventions already used in the codebase:
  - `UpperCamelCase` for types.
  - `lowerCamelCase` for methods/properties.
- Keep modules focused: models in `Models`, protocol/service code in `Services`.
- Prefer descriptive names that match MQTT/Zigbee terminology (`friendlyName`, `mqttConfig`, `httpPort`).

## Testing Guidelines
- Framework: `XCTest`.
- Place tests under `Tests/zmqtt2promTests/`.
- Name test methods as `test...` with behavior-focused wording (for example, `testDeviceEligibility`).
- Run `swift test` before opening a PR.
- Add/adjust tests for model decoding, flattening rules, and config validation when behavior changes.

## Commit & Pull Request Guidelines
- Current history favors concise, imperative messages and Conventional Commit style where helpful:
  - `fix test`
  - `Add TLS support (#6)`
  - `chore(deps): bump ...`
- Preferred format: `type(scope): summary` (`feat`, `fix`, `chore`, `test`, `docs`).
- PRs should include:
  - clear summary of behavior changes,
  - linked issue/PR context when available,
  - test evidence (`swift test` output),
  - doc/config updates when flags, env vars, or runtime behavior change.

## Subagent Workflow
Use this sequence for non-trivial tasks:

1. `task-triage`: classify task, risk, and touched paths.  
   Output: `Task Brief`.
2. `repo-mapper`: inspect `Package.swift`, impacted `Sources/...`, and `Tests/...`.  
   Output: `Impact Map`.
3. `change-planner`: define minimal steps and DoD.  
   Output: `Execution Plan`.
4. `swift-implementer`: apply code changes with existing style.
5. `test-runner`: run `swift build` + `swift test`.  
   Output: `Validation Report`.
6. `quality-reviewer`: detect regressions and CI incompatibilities.  
   Output: prioritized findings.
7. `pr-preparer`: produce final commit/PR text and checklist.

Handoff format between agents: short markdown block with `Context`, `Changes`, `Risks`, `Next`.
