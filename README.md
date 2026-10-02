# hackathon

A workshop-scale global AI weather-forecasting experiment using Anemoi, ERA5 and a Graph Transformer, carried out by **Muhammed Muhshif Karadan** during BSC’s “Machine Learning for Earth System Modeling: the Anemoi framework”, Barcelona, 28 September–1 October 2026.

**Purpose:** gain practical experience with dataset construction, graph configuration, GPU training, autoregressive inference and forecast verification. This is a small educational experiment and a single-case evaluation, not an operational forecasting system.

## Contribution and attribution

I configured and constructed the Anemoi dataset from workshop ERA5 inputs, configured and checked the graph, configured the Graph Transformer experiment, ran smoke/benchmark/production training, ran autoregressive inference, evaluated against ERA5 truth and persistence, and produced/interpreted diagnostic figures. These activities are reported by the experiment author; recovered configs, logs and notebook support key parts of the workflow.

Anemoi was developed by its contributors, including ECMWF and partners. BSC supplied workshop templates/helpers, training context and MareNostrum 5 access. I do not claim authorship of Anemoi, ERA5, BSC infrastructure or original workshop code. See [provenance](docs/provenance.md) and [licensing status](LICENSING.md). **Workshop redistribution licensing remains unresolved; this copy is for review before public release.**

## Experiment summary

| Component | Configuration |
|---|---|
| Data | ERA5; 48 variables; six-hourly |
| Split | Training: 2010–2013; internal validation/configured test: 2014; 2015 reserved by workshop organizers |
| Grid | O96; 40,320 data points |
| Forecast task | Two states, `X(t−6 h)` and `X(t)`, predict `X̂(t+6 h)`; training rollout: one |
| Inference | Autoregressive, initialized 2014-06-15 00:00 UTC; 24 h horizon |
| Forecast steps / evaluation leads | +6, +12, +18 and +24 h |
| Model | Graph Transformer; 128 channels; four processor layers; eight attention heads |
| Production training | 10,000 steps |
| Graph | 40,320 data nodes; 3,072 hidden nodes; cutoff factor 0.72; approximate radius 302.8 km |
| Evaluation | Latitude-weighted RMSE against ERA5 truth; initialization-time persistence baseline |
| Evaluated variables | 10u, 10v, 2t, msl, t_850, tp, z_500 |

The radius is author-reported; the graph configuration supports the hidden-node count and cutoff. Logged checkpoint metadata confirms the coordinate-array length, while the dataset variable count is author-reported. Evidence and limitations are described below.

**For this 24-hour test case, the model outperformed persistence for all seven evaluated variables at all four lead times.** The saved RMSE figure supports this comparison; it does not establish general forecast skill.

## Data preparation

ERA5 workshop inputs were on a 1° × 1° regular latitude–longitude grid. The recipe covers 2010-01-01 00:00 through 2014-12-31 18:00 and regrids by nearest neighbour to O96, an octahedral reduced Gaussian grid.

The author reports a dataset with 7,304 time steps, approximately 52.7 GiB logical size and 28–29 GiB compressed size.

The author reports successful initialization, 60 loading tasks, finalization/statistics and no missing data. The production store and its inspection logs are not included.

The 39 meteorological fields comprise z, q, t, u and v at 100, 250, 500, 700, 850 and 1000 hPa, plus tp, 2d, 2t, msl, sp, skt, tcw, 10u and 10v. Nine computed features are cos/sin latitude, longitude, Julian day and local time, plus insolation.

## Graph and model

The graph config uses HEALPix resolution 4, eight nearest neighbours for hidden-to-hidden edges and three for hidden-to-data edges. The author reports 69,960 encoder edges, 24,576 processor edges, 120,960 decoder edges and no isolated nodes. The final graph binary/diagnostics are not available in this copy, so those diagnostic counts remain author-reported.

The recovered YAML uses PyG graph attention and mixed 16-bit training. Precipitation is diagnostic, normalized by standard deviation and bounded with ReluBounding. The exact parameter count has not been verified and is omitted.

Training included a 20-step smoke run and a 1,000-step benchmark before the production run. A recovered final log explicitly reports `max_steps=10000` reached. The author reports an H100 GPU and approximately 15 min 33 s runtime on MareNostrum 5; exact runtime/GPU evidence has not been independently established here.

## Forecast and verification

Persistence repeats the initialization state at every forecast lead time.

The recovered notebook computes `w = cos(latitude in radians) / mean(cos(latitude))`, then `RMSE = sqrt(mean(w × (forecast − truth)²))`. On reduced O96 this cosine-latitude score differs from true cell-area weighting; it is retained to describe the original experiment faithfully. Training loss uses graph area weights separately.

![Model and persistence RMSE](figures/rmse_model_vs_persistence.png)

![ERA5 truth, forecast and error for 2-m temperature at +24 h](figures/spatial_truth_forecast_error_2t_24h.png)

Numerical RMSE values have not been recomputed without the external truth dataset; no numerical score table is supplied.

Autoregressive error growth is plausible, while the reported non-monotonic 2-m temperature persistence error may reflect the diurnal cycle. The reported smaller precipitation improvement is a case-specific observation, not a demonstrated causal conclusion. Here tp represents the preceding six-hour interval, not accumulation since forecast initialization; the author reports the corresponding inference accumulation warning.

## Limits and reproducibility

Only one initialization was evaluated, within the internal validation year. This does not establish general superiority, independent held-out test skill or operational performance. Robust verification needs multiple dates, appropriate area weighting, statistical uncertainty and confirmation of training-only normalization statistics.

No ERA5/BSC input data, Zarr stores, checkpoint, graph binaries or forecast NetCDF are distributed. Reproduction requires compatible external inputs, software, graph and weights. See [reproduction prerequisites and recovered commands](docs/reproducibility.md) and [environment evidence](environment/README.md). The cleaned workflow has not been rerun here and is not claimed to be immediately runnable on a Mac.

## Dataset availability notice

The dataset used in this experiment is not currently available in this GitHub repository. If redistribution is permitted and a suitable archive can be prepared, I intend to provide a Zenodo link in a future update. No release date is confirmed. Thank you for your understanding.

## Acknowledgements

BSC workshop organizers and instructors; MareNostrum 5 infrastructure; Anemoi contributors; ECMWF and the Copernicus Climate Change Service for ERA5. Attribution does not imply endorsement.
