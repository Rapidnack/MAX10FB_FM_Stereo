# MAX10FB_FM_Stereo

MAX10FB_FM_Stereoプロジェクトは、Intel MAX10 FPGAを使ったFMステレオラジオのVerilogソースコードです。

![全体画像](http://rapidack.sakura.ne.jp/ttl/wp-content/uploads/2020/01/2a530f0582270c1bd6df40102773e11e.png)

- 開発環境: Quartus Prime Lite Edition 18.1
- FPGAボード: CQ出版社「FPGA電子工作スーパーキット」付録基板 MAX10-FB
- コントローラ: ESP32
- ADC: Analog Devices AD9283
- I2S DAC: PCM5102A

選局、音量はESP32のタッチセンサーを使います。
別プロジェクト[AvalonPacket](https://github.com/Rapidnack/AvalonPacket)のArduinoライブラリをArduino IDEにインポートし、
サンプルスケッチAvalonPacket_FM_Radioを書き込んでください。

![操作パネル](http://rapidack.sakura.ne.jp/ttl/wp-content/uploads/2019/03/FrontPanel.png)

  
# メモ

SPIを接続した状態でFPGAへのsofファイルの書き込みに失敗することがあります。その場合はpofファイルを書き込んでください。
  
# Authors

[Rapidnack](http://rapidnack.com/)

# References

[https://github.com/Rapidnack/AvalonPacket](https://github.com/Rapidnack/AvalonPacket)
