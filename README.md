# Recognized-Text by FirebaseML

完成形をYoutubeにアップロードしました！
https://www.youtube.com/watch?v=8JIr2cjixGo&ab_channel=%E7%A5%9E%E6%9D%91%E4%BA%AE%E4%BD%91



<img src="https://user-images.githubusercontent.com/52638834/92302892-f4471780-efaa-11ea-944e-9c77e3c54908.gif" alt="drawing" width="600"/>



FirebaseMLには、デバイス版とクラウド版があります。
今回はクラウド版でテキスト認識を行っってみました。
ぜひ、参考にしていただけると幸いです！



### 手順(4つ)


#### ①Firebaseと連携

[Firebaseのセットアップ](https://firebase.google.com/docs/ios/setup)を参照してください


#### ②Podfileの追加

ターミナルでPodfileを開き
```
pod 'Firebase/MLVision'
```
を追加してください！


#### ③FirebaseコンソールでクラウドベースのAPIを有効にしてください


<img src="https://user-images.githubusercontent.com/52638834/92322611-333da180-f06d-11ea-81da-0deb644e423e.png" alt="drawing" width="600"/>


#### ④ContentView.swiftをコピペしてください

[ContentView.swift](https://github.com/Ryosukekamimura/Recognize_Text/blob/4891076c5c16e3041a674d66039c97b1196866ca/Recognize_Text/ContentView.swift)からコピペしてください












