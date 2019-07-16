
# Livestream-shopping
---


## project 特色：
1. 有後端工程師配合開 RESTful API 進行串接。
2. 串接 Facebook SDK
3. 使用 Trello 規定開發流程
4. 參與這個 side project 的，有 APP 端的 iOS 與 Android，以及 Web 端的 Front-End 與 backend。

 

<img src="https://github.com/aa08666/Livestream-shopping_iOS/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%208%20Plus%20-%202019-07-16%20at%2017.16.15.png" width="500" height="800"/>

---
**運行流程：**
1. 這邊我將會簡單的描述一下這個專案的流程
2. 我們的賣家開了一場Facebook直播，並取得直播網址
3. 賣家登入我們的服務，新增等等要賣的商品資料
4. 賣家在我們的服務內，輸入等等直播的網址，還有針對這場直播的一些敘述。然後我們的服務會提供給賣家一個頻道的識別碼
5. 若此時因不可抗因素，賣家與服務斷開，當賣家再次與我們的服務連接時，我們的服務會記得上一次的狀態，並且詢問賣家是否要繼續上一次的狀態，或者重新開始
6. 這時候，買家經由賣家FB的聊天視窗，取得我們服務的頻道識別碼
7. 買家輸入剛剛拿到的頻道識別碼，然後加入頻道，這時候因為賣家還沒有推播任何商品，所以畫面上是顯示尚未有商品在推播中
8. 賣家推播第一個商品，商品推播之後，我們可以在畫面上看到商品的圖片，名稱，以及剩餘的數量，還有已賣數量
9. 買家可以自由地選擇想要的數量，並且下單！買家下單之後，商品目前的剩餘數量會再買賣雙方即時更新！
10. 買家下單之後，會即時的收到Email確認信
11. 當賣家結束直播之後，買家畫面會即時顯示直播已關閉
---

## 開發 Trello 
<img src="https://github.com/aa08666/Livestream-shopping_iOS/blob/master/Screen%20Shot%202019-07-16%20at%2017.33.12.png" width="900" height="700" >

---
[後端 API 文件](https://tn710617.github.io/API_Document/FacebookOptimizedSellingSystem/#%E8%B2%B7%E5%AE%B6-buyer-%E4%B8%8B%E5%96%AE-place-an-order-post)
