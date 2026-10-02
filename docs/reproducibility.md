# Reproduction prerequisites and recovered workflow

This is a documented experiment, not a data-free executable demonstration. ERA5 input NetCDFs, the production Zarr store, trained checkpoint and final graph are not included. Supply legally accessible inputs with the same layout and verify their metadata and precipitation intervals.

Set these environment variables to your own absolute paths:

```bash
export HACKATHON_ROOT="$PWD"
export ERA5_INPUT_ROOT="/path/to/era5-inputs"
export ANEMOI_DATASET="/path/to/hackathon.zarr"
export ANEMOI_GRAPH="/path/to/hackathon_o96_cutoff072.pt"
export ANEMOI_CHECKPOINT="/path/to/inference-last.ckpt"
export ANEMOI_RUNS="/path/to/training-runs"
export ANEMOI_OUTPUT="$HACKATHON_ROOT/outputs/inference"
mkdir -p "$ANEMOI_OUTPUT"
```

The dataset recipe expects pl/ and sl/ directories with yearly workshop-style filenames (see configs/dataset.yaml), 2010–2014 inclusive, pressure fields z/q/t/u/v at 100/250/500/700/850/1000 hPa, and surface fields tp/2d/2t/msl/sp/skt/tcw/10u/10v. It renames u10/v10/d2m/t2m, regrids by nearest neighbour from 1 degree to O96, and computes nine forcings. Equivalent newly obtained ERA5 inputs may require preprocessing; no downloader is supplied.

Recovered dataset command, deliberately without automatic overwrite:

```bash
anemoi-datasets create configs/dataset.yaml "$ANEMOI_DATASET"
anemoi-datasets inspect "$ANEMOI_DATASET" --detailed --statistics --size
```

The original serial job also patched dataset resolution metadata to O96. The production run used initialization, monthly loading and finalization; a portable parallel-job reconstruction is not supplied here. Inspect the installed CLI and graph diagnostics before constructing a replacement graph. The graph YAML is preserved but graph creation has not been executed here.

Recovered training commands:

```bash
cd "$HACKATHON_ROOT/configs"
anemoi-training config validate --config-name hackathon_forecast
anemoi-training train --config-name hackathon_forecast
```

For Slurm, activate a suitable environment first and pass your own account/partition/resource options to sbatch scripts/train.slurm. Site-specific options cannot be inferred for another cluster. Smoke and benchmark configs are retained for 20 and 1,000 steps; final config uses 10,000.

Recovered inference command:

```bash
cd "$HACKATHON_ROOT"
anemoi-inference run --config configs/model-inference.yaml
```

Open notebooks/hackathon_inference.ipynb from within hackathon to evaluate an existing forecast against the supplied Zarr truth. The notebook is cleaned but has not been executed here; it requires external data. It preserves the original cosine-latitude metric. Dataset-wide normalization statistics may include 2014; training-only statistics have not been established. Investigate this before stronger generalization claims.
