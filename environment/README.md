# Environment evidence

The recovered workshop manifest requires Python 3.12 and pins the Module 03–04 stack: anemoi-datasets 0.5.36, graphs 0.9.3, inference 0.10.1, models 0.14.1, training 0.12.1, transform 0.3.1, utils 0.5.3, torch 2.10.0 and torch-geometric 2.7.0. See workshop-pyproject.toml and workshop-uv.lock for the full recovered specification.

These manifests describe the workshop environment; they are not proof of every installed package in the production run and have not been installed or tested here. The original pyproject references an absent upstream README. Do not assume the archived files form an immediately installable project. CUDA training/inference requires suitable GPU infrastructure. Apple M3 does not provide CUDA; no Mac training or MPS compatibility claim is made.
