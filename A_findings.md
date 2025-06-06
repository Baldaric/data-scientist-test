## Anomaly Findings

I identified 137 transactions where `decoy_noise` differed from `payment_value` by more than 100 units, suggesting artificially introduced numeric noise.

Notably, 118 transactions contained **negative values in `decoy_noise`**, which is not valid for payment data. This strongly indicates the presence of injected or corrupted records, as there is no indication of refunds or reversals in the dataset schema.

Additionally, among the noisy records, the most frequent `decoy_flag` was `'C'`, suggesting that numeric anomalies are most concentrated in otherwise “normal” categories.

These patterns were discovered using:
- `ABS(payment_value - decoy_noise) > 100`
- `decoy_noise < 0`
- `GROUP BY decoy_flag` for anomaly distribution