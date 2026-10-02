# Provenance and changes

The experiment was carried out by Muhammed Muhshif Karadan using BSC workshop materials and Anemoi. Authorship of original templates and helpers is not claimed. Exact personal changes cannot all be reconstructed without an authoritative upstream revision.

| Clean file | Uploaded source (relative to archive project root) | Original SHA-256 |
|---|---|---|
| `configs/hackathon_forecast.yaml` | `hackathon-templates/configs/hackathon_forecast.yaml` | `fe6c0be21327969ec1bc08cc006ad074d0d1206b6594b59ab8943f3aced3c994` |
| `configs/hackathon_forecast_smoke20.yaml` | `hackathon-templates/configs/hackathon_forecast_smoke20.yaml` | `5cf8f6c8611c2a6ff882676346d43f0c037203adbee9a7402ad34f95432a3d48` |
| `configs/hackathon_forecast_benchmark1000.yaml` | `hackathon-templates/configs/hackathon_forecast_benchmark1000.yaml` | `d0c0deaaf4810ba3cda68f30d6696465d56492fb6b43a168c974712d62ab1d8f` |
| `configs/model-inference.yaml` | `hackathon-templates/configs/model-inference.yaml` | `8775f217ab26dfd50b10921c2f835846dc93cb5900df5717d1ac2e86896add73` |
| `configs/graph/hackathon_o96.yaml` | `hackathon-templates/configs/graph/hackathon_o96.yaml` | `7759be9f35eb05b5aebd3781d4c2c3231146eeec478206dc39c005e5f64baacf` |
| `configs/training/scalers/hackathon.yaml` | `hackathon-templates/configs/training/scalers/hackathon.yaml` | `10f560710fb5ce312a0934b4e8aad6b989aca3f120632e208e416ef7cd94346b` |
| `configs/dataset.yaml` | `hackathon-templates/configs/hackathon-ea-an-oper-0001-mars-o96-2010-2014-6h-v1.yaml` | `60376585d631a3e18226be511ccaac6136dc95bf04ed0315d9da60915d0b1b14` |
| `notebooks/helpers.py` | `hackathon-templates/notebooks/helpers.py` | `4a85b8e56da7642e58a28cc5a5cfc8c37301bb31e24b864f194d36cbcbe57e38` |
| `figures/rmse_model_vs_persistence.png` | `hackathon-templates/figures/rmse_model_vs_persistence.png` | `83f46c7e87b66f4f69ebd453507f5f353f0d056bfca362b7c99f0f5f3c074d69` |
| `figures/spatial_truth_forecast_error_2t_24h.png` | `hackathon-templates/figures/spatial_truth_forecast_error_2t_24h.png` | `2ceecb416ae0377721f21226e05493faf0ba0d1386bddaf49fd7a239c65c2e55` |
| `environment/workshop-pyproject.toml` | `pyproject.toml` | `ca6dd08f779cb249abc3109f783883990822f1f33ba8ce0d967ef16fe0a51531` |
| `environment/workshop-uv.lock` | `uv.lock` | `eacc084d32fb2af108070070f6237b064aeff2fb92320462d76a682de811035e` |
| `notebooks/hackathon_inference.ipynb` | `hackathon-templates/notebooks/hackathon_inference.ipynb` | `f166752893609d91849a9ddc41428e3106472fbb364856defaa20c9855b635b1` |

Public-copy changes: configurable paths; notebook outputs cleared; execution order repaired; unused/debug cells removed; descriptive summary assertions removed; data-license declaration removed pending verification. The new Slurm example is adapted from the recovered training job, without the original account, reservation, environment activation or machine paths. Figures and helper bytes are unchanged. Environment manifests are archived evidence, not a tested portable environment.

Excluded: nested workshop copy, Module 0 Zarr stores, unrelated workshop modules, macOS metadata, caches, backup configs, raw logs, resolved Hydra configs, graph binaries, forecast NetCDF, checkpoints and account spreadsheets.
