# Verilog Bowling Score-Keeping System

[cite_start]國立臺灣科技大學「數位系統設計」課程專題 [cite: 2198]
* [cite_start]**組員**: 彭成任, 彭弼暉 [cite: 2200]

## 專案描述 (Project Description)

本專案旨在以 Verilog HDL 設計並驗證一個能夠精確計算保齡球分數的數位系統。系統的核心由一個有限狀態機 (Finite State Machine, FSM) 控制，能夠根據保齡球複雜的計分規則，正確處理全倒 (Strike)、補中 (Spare) 以及第十局的額外加分球，並將最終分數以 BCD 碼形式輸出至七段顯示器。

This project is a digital score-keeping system for bowling, designed and verified using Verilog HDL. The core of the system is a Finite State Machine (FSM) that accurately calculates the score based on the complex rules of bowling, correctly handling Strikes, Spares, and the bonus throws in the 10th frame. The final score is converted to BCD for display on seven-segment displays.

## 系統架構 (System Architecture)

[cite_start]本系統採用業界標準的 **Datapath-Controller** 架構進行設計，將負責運算的「資料路徑」與負責狀態決策的「控制器」分離，使得設計清晰、易於除錯與擴展 [cite: 146, 147]。

* [cite_start]**Controller**: 作為系統的大腦，此 FSM 負責解讀輸入的瓶倒數，並根據當前局數與投球次數，判斷是否為 Strike 或 Spare，發出對應的控制訊號 (如 `AD` - Add Score, `NF` - Next Frame) 給 Datapath [cite: 147]。
* [cite_start]**Datapath**: 負責執行所有算術運算與資料儲存。它包含以下主要子模組 [cite: 146]：
    * `score_register`: 儲存當前總分的暫存器。
    * `frame_counter`: 追蹤目前所在的局數。
    * `APD_logic`: 判斷當局是否達成全倒 (All Pins Down) 的邏輯單元。
    * [cite_start]`Binary_to_BCD`: 將二進位的總分轉換為 BCD 碼 [cite: 134]。
    * [cite_start]`BCD_to_Seven_Segment`: 將 BCD 碼轉換為七段顯示器的驅動訊號 [cite: 130]。

## 主要特色 (Key Features)

* **複雜計分邏輯實現 (Complex Scoring Logic)**: 成功實現保齡球規則，能精確處理 Strike 和 Spare 對後續分數的加成效果。
* **高模組化設計 (Highly Modular Design)**: 系統被切分為多個獨立的功能模組，每個模組皆可獨立進行測試，展現了良好的硬體設計風格。
* [cite_start]**完整的功能驗證 (Comprehensive Verification)**: 為了確保設計的穩健性，我們撰寫了多個 Testbench 來模擬各種邊界條件 [cite: 140, 142, 144]：
    * [cite_start]**滿分測試 (Perfect Game)**: 驗證連續 12 次 Strike 後分數是否正確為 300 分 [cite: 140]。
    * [cite_start]**無加分局測試 (Open Frame)**: 驗證在第十局無 Strike 或 Spare 的情況下，計分是否正常結束 [cite: 142]。
    * [cite_start]**混合情境測試 (Mixed Scenario)**: 包含洗溝 (Gutter)、Spare、Strike 與一般計分的複雜情境，確保所有邏輯分支的正確性 [cite: 143, 144]。

## 設計與驗證工具 (Tools Used)

* **設計語言**: Verilog HDL
* **模擬軟體**: ModelSim

## 檔案結構 (File Structure)

```
.
├── rtl/              <-- 存放所有Verilog設計檔 (.v)
│   ├── score_keeping_top.v
│   ├── controller.v
│   ├── datapath.v
│   └── (其他子模組.v)
├── sim/              <-- 存放Testbench檔案 (_tb.v)
│   └── score_keeping_tb.v
├── doc/              <-- 存放專案報告
│   └── 數位系統設計_Term_Project.pdf
└── README.md         <-- This file
```

## 如何模擬 (How to Simulate)

主要的測試平台為 `sim/score_keeping_tb.v`。檔案內已包含多種測試情境，您可以透過註解/取消註解的方式選擇要運行的測試案例，並使用 ModelSim 等標準 Verilog 模擬器進行驗證。
