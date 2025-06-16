# AgenticSeek Codebase Overview

## General Structure

This repository contains an AI assistant that runs locally, able to browse the web, execute code and plan tasks. The main documentation (README.md) describes it as a "100% local alternative to Manus AI" with features such as autonomous browsing, code generation and agent selection.

```
# AgenticSeek: Private, Local Manus Alternative.
...
*A **100% local alternative to Manus AI**, this voice-enabled AI assistant autonomously browses the web, writes code, and plans tasks while keeping all data on your device.*
```

The project is organized into several top-level directories:

- `sources/` – core Python package (agents, tools, browser helpers, memory management, etc.)
- `frontend/` – React-based web UI
- `llm_router/` and `llm_server/` – models for routing and backend
- `scripts/` – helper scripts
- `tests/` – minimal test suite
- `prompts/` – prompt templates for agents
- `docs/` – contribution guide and architecture diagrams

## Core Concepts

### Agents and Tools

Agents implement autonomous behaviors. They inherit from `Agent` and use "tools" for actions such as executing code or searching the web. Key properties are set in the base class:

```python
class Agent():
    """An abstract class for all agents."""
    def __init__(self, name: str, prompt_path: str, provider, verbose=False, browser=None) -> None:
        ...
        self.tools = {}
        self.blocks_result = []
        self.success = True
        self.status_message = "Haven't started yet"
```

Agents parse tool blocks in their responses and execute them through `execute_modules`.

Tools are described in `docs/CONTRIBUTING.md`. Developers implement three methods: `execute`, `execution_failure_check`, and `interpreter_feedback`.

### Agent Routing

The routing logic decides which agent should handle a query. The contribution guide outlines the four steps of agent selection:

```
The agent selection is done in 4 steps:
1. determine query language and translate to english for the zero-shot model and llm_router.
2. Estimate the task complexity and best agent.
   - If HIGH complexity: return the planner agent.
   - If LOW complexity: Determine the best agent for the task using a vote system between 2 classification models.
3. Process high complexity query.
   - If task was high complexity, planner agent will create a json plan to divide and conqueer the task with multiple agent.
4. Proceed with task(s)
```

### Memory and Provider

- `memory.py` manages conversation history, optionally compressing it with a summarization model.
- `llm_provider.py` abstracts access to local or remote language models (Ollama, LM Studio, OpenAI, etc.).

### API and Frontend

`api.py` exposes FastAPI routes for interaction. It initializes providers and agents, serving as the backend for the frontend web interface located under `frontend/`.

## Getting Started

1. Follow the setup instructions in `README.md` to clone the repo, configure `.env` and `config.ini`, and start Docker services.
2. Use `docker compose --profile full up` to run the backend and the React frontend, then access the app on `http://localhost:3000`.
3. For CLI usage, run `python3 cli.py` after installation.

## Suggested Next Steps for Newcomers

- Read `docs/CONTRIBUTING.md` for guidelines on tool and agent development.
- Review the `sources/agents` and `sources/tools` modules to understand how agents execute tasks.
- Explore `tests/` for examples of how modules are exercised.
- Try creating a simple tool or modifying an existing prompt in `prompts/` to see how agent behavior changes.

