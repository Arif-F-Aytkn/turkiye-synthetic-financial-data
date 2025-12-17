# 📊 Synthetic Financial & Demographic Simulation of Turkey

This repository contains a **MATLAB-based statistical simulation model** that generates a synthetic micro-level financial and demographic dataset representing individuals in Turkey.

The project focuses on modeling:
- Income formation
- Credit scoring
- Risk perception
- Investment behavior (stocks, real estate, cash, crypto, commodities)
- Regional development differences (SEGE index)

⚠️ **All data is fully synthetic** and does not contain any real personal information.

---

## 📁 Repository Structure

```text
.
├── Fintech_Sim_9.m
│
├── Sehir ve SEGE Dogrulamasi.png
├── Cinsiyet Etkisi Dogrulamasi.png
├── Egitim Seviyesi ve Maas Etkisi.png
├── Deneyim Yili ve Toplam Yatirim (Trend).png
├── Egitim ve Finansal Okuryazarlik (Borsa Katilimi).png
├── Mesleklere Gore Portfoy Dagilimi.png
├── Risk Algisinin Yatirima Etkisi (Altin vs Hisse).png
├── Maas ve Kredi Notu Iliskisi.png
│
├── README.md
└── LICENSE
```

## 🧠 Simulation Highlights

### 🔹 Demographics
- Age (18–70)
- Gender
- Education level
- Marital status
- Work experience

### 🔹 Regional Structure
- 81 provinces
- Population-weighted city sampling
- SEGE development index (1 = most developed, 6 = least)

### 🔹 Economic & Financial Variables
- Occupation-based income generation
- Education & experience adjusted wages
- Credit score simulation (0–1900)
- Risk perception (1–5)

### 🔹 Investment Behavior (Zero-Inflated Model)
- Stocks (Hisse)
- Real estate (Gayrimenkul)
- Cash
- Cryptocurrency
- Commodities (Gold)
- Mutual funds

Participation in investment instruments is modeled using **probability filters**, reflecting real-world financial literacy and access differences in Turkey.

---

## 📈 Model Validation & Visual Analysis

The following plots are generated directly from the simulation to validate economic intuition:

- **SEGE vs Income Distribution**  
  _Sehir ve SEGE Dogrulamasi.png_

- **Gender Effect on Commodity (Gold) Investment**  
  _Cinsiyet Etkisi Dogrulamasi.png_

- **Education Level vs Income**  
  _Egitim Seviyesi ve Maas Etkisi.png_

- **Work Experience vs Total Wealth (Trend)**  
  _Deneyim Yili ve Toplam Yatirim (Trend).png_

- **Education & Financial Literacy (Stock Market Participation)**  
  _Egitim ve Finansal Okuryazarlik (Borsa Katilimi).png_

- **Portfolio Allocation by Occupation**  
  _Mesleklere Gore Portfoy Dagilimi.png_

- **Risk Perception: Gold vs Stock Preference**  
  _Risk Algisinin Yatirima Etkisi (Altin vs Hisse).png_

- **Income vs Credit Score Relationship**  
  _Maas ve Kredi Notu Iliskisi.png_

---

## 🧪 Use Cases

This project and generated data can be used for:
- Econometrics & applied statistics
- Machine learning (classification & regression)
- Credit risk modeling
- Financial behavior analysis
- Portfolio allocation studies
- Synthetic data generation research

---

## 🔗 Dataset Availability

The generated dataset is published on **Kaggle**:

➡️ **Kaggle Dataset:** *(add your Kaggle link here)*

---

## ⚙️ How to Run

1. Open MATLAB
2. Run:
   ```matlab
   Fintech_Sim_9.m
    ```

The script will:
- Generate synthetic data
- Compute financial variables
- Produce validation plots

---

## 📜 License

This project is licensed under the **MIT License**.  
You are free to use, modify, and distribute the code with attribution.

---

## ✍️ Author

**Arif Furkan Aytekin**  
Statistics & Data Science Enthusiast
