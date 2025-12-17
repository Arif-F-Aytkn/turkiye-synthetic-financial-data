clear; clc;
rng(2025);
N = 10000;

%% ADIM 1: ŞEHİR VE SEGE ALTYAPISI (81 İL)
ID = (1:N)';

% 1. TÜİK Nüfus Oranlarına Göre Şehir Seçimi
Olasiliklar = [0.0266, 0.0071, 0.0088, 0.0058, 0.0040, 0.0685, 0.0318, 0.0020, ...
    0.0136, 0.0149, 0.0027, 0.0033, 0.0042, 0.0038, 0.0032, 0.0378, 0.0066, 0.0023, 0.0061, 0.0124, 0.0214, ...
    0.0049, 0.0071, 0.0028, 0.0087, 0.0108, 0.0256, 0.0053, 0.0017, 0.0033, 0.0182, 0.0052, 0.0228, 0.1833, ...
    0.0525, 0.0032, 0.0045, 0.0170, 0.0044, 0.0029, 0.0249, 0.0272, 0.0067, 0.0088, 0.0172, 0.0132, 0.0105, ...
    0.0126, 0.0046, 0.0037, 0.0044, 0.0090, 0.0041, 0.0130, 0.0161, 0.0039, 0.0026, 0.0074, 0.0139, 0.0072, ...
    0.0096, 0.0010, 0.0261, 0.0044, 0.0131, 0.0048, 0.0068, 0.0051, 0.0010, 0.0031, 0.0033, 0.0076, 0.0067, ...
    0.0024, 0.0011, 0.0024, 0.0036, 0.0029, 0.0018, 0.0065, 0.0048];

Sehir_Kod = randsample(1:81, N, true, Olasiliklar)';

Sehir_Listesi = {'Adana','Adiyaman','Afyonkarahisar','Agri','Amasya','Ankara','Antalya','Artvin','Aydin','Balikesir',...
    'Bilecik','Bingol','Bitlis','Bolu','Burdur','Bursa','Canakkale','Cankiri','Corum','Denizli',...
    'Diyarbakir','Edirne','Elazig','Erzincan','Erzurum','Eskisehir','Gaziantep','Giresun','Gumushane','Hakkari',...
    'Hatay','Isparta','Mersin','Istanbul','Izmir','Kars','Kastamonu','Kayseri','Kirklareli','Kirsehir',...
    'Kocaeli','Konya','Kutahya','Malatya','Manisa','Kahramanmaras','Mardin','Mugla','Mus','Nevsehir',...
    'Nigde','Ordu','Rize','Sakarya','Samsun','Siirt','Sinop','Sivas','Tekirdag','Tokat',...
    'Trabzon','Tunceli','Sanliurfa','Usak','Van','Yozgat','Zonguldak','Aksaray','Bayburt','Karaman',...
    'Kirikkale','Batman','Sirnak','Bartin','Ardahan','Igdir','Yalova','Karabuk','Kilis','Osmaniye','Duzce'};

Sehir_Adi = Sehir_Listesi(Sehir_Kod)';

% 2. SEGE Puanlaması
Sege_Puan = zeros(N, 1);
Group1 = [34, 6, 35, 41, 7, 16, 26, 48];
Group2 = [77, 59, 20, 54, 33, 42, 17, 14, 38, 10, 22, 45, 9];
Group3 = [1, 39, 61, 32, 11, 55, 78, 81, 27, 43, 53, 50, 64, 15, 70, 67, 71];
Group4 = [5, 40, 8, 3, 19, 44, 58, 24, 23, 68, 37];
Group5 = [31, 28, 79, 18, 52, 25, 74, 80, 62, 57, 51, 60, 69, 46, 66];
Group6 = [29, 21, 72, 75, 2, 12, 36, 47, 76, 65, 13, 56, 30, 73, 63, 49, 4];

Sege_Puan(ismember(Sehir_Kod, Group1)) = 1;
Sege_Puan(ismember(Sehir_Kod, Group2)) = 2;
Sege_Puan(ismember(Sehir_Kod, Group3)) = 3;
Sege_Puan(ismember(Sehir_Kod, Group4)) = 4;
Sege_Puan(ismember(Sehir_Kod, Group5)) = 5;
Sege_Puan(ismember(Sehir_Kod, Group6)) = 6;
Sege_Puan(Sege_Puan == 0) = 4; 

Is_Sege12 = (Sege_Puan <= 2);
Is_Sege56 = (Sege_Puan >= 5);

%% ADIM 2: DEMOGRAFİK VE SOSYAL DEĞİŞKENLER

Yas = randi([18, 70], N, 1);
Norm_Yas = (Yas - 18)/(70-18);

% Cinsiyet (Etkisiz)
Cinsiyet_Kod = randsample([1, 2], N, true, [0.5, 0.5])';
Cinsiyet_Etiketleri = {'Kadin', 'Erkek'};
Cinsiyet = Cinsiyet_Etiketleri(Cinsiyet_Kod)';

Olasilik_Evli = 1 ./ (1 + exp(-0.15 * (Yas - 28)));
Is_Evli = (rand(N, 1) < Olasilik_Evli);
Medeni_Durum = cell(N,1); Medeni_Durum(Is_Evli)={'Evli'}; Medeni_Durum(~Is_Evli)={'Bekar'};

% Eğitim
Prob_Egitim = [0.30, 0.35, 0.25, 0.10]; 
Egitim_Kod = randsample(1:4, N, true, Prob_Egitim)';
Maske_Egitim = Is_Sege12 & (rand(N, 1) < 0.3); 
Egitim_Kod(Maske_Egitim) = min(Egitim_Kod(Maske_Egitim) + 1, 4);
Egitim_Listesi = {'Ilkogretim', 'Lise', 'Lisans', 'LisansUstu'};
Egitim_Durumu = Egitim_Listesi(Egitim_Kod)';

% Deneyim Yılı
Baslama_Yaslari = [16, 18, 23, 26];
Kisi_Baslama_Yasi = Baslama_Yaslari(Egitim_Kod)';
Deneyim_Yil = Yas - Kisi_Baslama_Yasi - randi([0, 2], N, 1);
Deneyim_Yil(Deneyim_Yil < 0) = 0;


% --- MESLEK ATAMA ---
% 1:Ogrenci, 2:MaviYaka, 3:Memur, 4:BeyazYaka, 5:Esnaf, 6:Emekli, 
% 7:Muhendis, 8:Finansci, 9:Emlakci, 10:Kuyumcu
Meslek_Kod = zeros(N, 1);

for i = 1:N
    if Yas(i) < 25 && Egitim_Kod(i) >= 2 && rand < 0.50
        Meslek_Kod(i) = 1; % Öğrenci
    elseif Yas(i) > 60 && rand < 0.80
        Meslek_Kod(i) = 6; % Emekli
    else
        % ÇALIŞAN HAVUZU OLUŞTURUYORUZ
        if Egitim_Kod(i) <= 2 
            % Lise ve altı: MaviYaka, Esnaf ağırlıklı
            % Emlakçı ve Kuyumcu Lise mezunu olabilir.
            Meslek_Kod(i) = randsample([2, 3, 4, 5, 9, 10], 1, true, [0.50, 0.10, 0.10, 0.25, 0.03, 0.02]);
        else 
            % Üniversite: Mühendis, Finans, Beyaz Yaka
            if Is_Sege12(i) 
                 % Gelişmiş İl
                Prob = [0.05, 0.20, 0.25, 0.10, 0.25, 0.10, 0.03, 0.02]; 
                % [Mavi, Memur, Beyaz, Esnaf, Muhendis, Finans, Emlak, Kuyum]
                Secenekler = [2, 3, 4, 5, 7, 8, 9, 10];
                Meslek_Kod(i) = randsample(Secenekler, 1, true, Prob);
            else
                % Diğer İl
                Prob = [0.05, 0.40, 0.15, 0.15, 0.15, 0.02, 0.05, 0.03];
                Secenekler = [2, 3, 4, 5, 7, 8, 9, 10];
                Meslek_Kod(i) = randsample(Secenekler, 1, true, Prob);
            end
        end
    end
end
Meslek_Listesi = {'Ogrenci', 'MaviYaka', 'Memur', 'BeyazYaka', 'Esnaf', ...
                  'Emekli', 'Muhendis', 'Finansci', 'Emlakci', 'Kuyumcu'};
Meslek = Meslek_Listesi(Meslek_Kod)';

% Risk Algısı
Min_Puan = 1.5;
Max_Puan = 4.8;
Slope = (Max_Puan - Min_Puan) / (70 - 18);
Risk_Baz = Min_Puan + ((Yas - 18) * Slope);
Risk_Baz(Egitim_Kod >= 3) = Risk_Baz(Egitim_Kod >= 3) + 0.3;
Risk_Baz(Cinsiyet_Kod == 2) = Risk_Baz(Cinsiyet_Kod == 2) + 0.2;
Risk_Baz(Is_Sege12) = Risk_Baz(Is_Sege12) + 0.2;
Risk_Algisi_Raw = Risk_Baz + (randn(N, 1) * 0.9);
Risk_Algisi = round(Risk_Algisi_Raw);
Risk_Algisi(Risk_Algisi < 1) = 1; 
Risk_Algisi(Risk_Algisi > 5) = 5;

%% ADIM 3: FİNANSAL MOTOR

Baz_Maas = 17002;
Sege_Carpan = [1.40, 1.25, 1.10, 1.00, 0.95, 0.90]; 
Kisi_Sege_Carpan = Sege_Carpan(Sege_Puan)';

% 1. MAAŞ ÇARPANLARI
Meslek_Carpan = ones(N, 1);
Meslek_Carpan(Meslek_Kod == 1) = 0.3; % Öğrenci
Meslek_Carpan(Meslek_Kod == 2) = 1.1; % Mavi Yaka
Meslek_Carpan(Meslek_Kod == 3) = 1.9; % Memur
Meslek_Carpan(Meslek_Kod == 4) = 2.2; % Beyaz Yaka
Meslek_Carpan(Meslek_Kod == 5) = 2.2; % Esnaf
Meslek_Carpan(Meslek_Kod == 6) = 0.7; % Emekli
Meslek_Carpan(Meslek_Kod == 7) = 2.6; % Mühendis
Meslek_Carpan(Meslek_Kod == 8) = 3.0; % Finansçı
Meslek_Carpan(Meslek_Kod == 9) = 2.5; % Emlakçı
Meslek_Carpan(Meslek_Kod == 10)= 3.5; % Kuyumcu 

Egitim_Bonus = [1.0, 1.1, 1.25, 1.50];
Kisi_Egitim_Bonus = Egitim_Bonus(Egitim_Kod)';

% Maaş Hesaplama
Final_Carpan = ones(N, 1);
for i = 1:N
    Deneyim_Carpani = 1 + (Deneyim_Yil(i) * 0.03);
    
    if Meslek_Kod(i) == 3 % MEMUR
        Final_Carpan(i) = 1.05 * Meslek_Carpan(i) * Kisi_Egitim_Bonus(i) * Deneyim_Carpani;
    elseif Meslek_Kod(i) == 8 % FİNANSÇI
        Final_Carpan(i) = (Kisi_Sege_Carpan(i)^1.5) * Meslek_Carpan(i) * Kisi_Egitim_Bonus(i) * Deneyim_Carpani;
    elseif ismember(Meslek_Kod(i), [5, 9, 10]) 
        Final_Carpan(i) = Kisi_Sege_Carpan(i) * Meslek_Carpan(i) * Deneyim_Carpani * lognrnd(0, 0.5); 
    else
        Final_Carpan(i) = Kisi_Sege_Carpan(i) * Meslek_Carpan(i) * Kisi_Egitim_Bonus(i) * Deneyim_Carpani;
    end
end
Maas = round(Baz_Maas .* Final_Carpan .* lognrnd(0, 0.1, N, 1));
Norm_Maas = (Maas - min(Maas))/(max(Maas)-min(Maas));

% Kredi Notu
Baz_Puan = 1000;
Bonus_Meslek = zeros(N, 1);
Bonus_Meslek(Meslek_Kod == 3) = 150; % Memur
Bonus_Meslek(Meslek_Kod == 4) = 100; % Beyaz Yaka
Bonus_Meslek(Meslek_Kod == 6) = 80;  % Esnaf
Bonus_Meslek(Meslek_Kod == 7) = 130; % Mühendis
Bonus_Meslek(Meslek_Kod == 8) = 140; % Finansçı
Bonus_Meslek(Meslek_Kod == 9) = 110; % Emlakçı 
Bonus_Meslek(Meslek_Kod == 10)= 160; % Kuyumcu 

Sege_Etkisi = [100, 70, 40, 10, -20, -40];
Kisi_Sege_Etkisi = Sege_Etkisi(Sege_Puan)';

Kredi = round(Baz_Puan + Kisi_Sege_Etkisi + Bonus_Meslek + (Norm_Maas * 400) + (Deneyim_Yil*5) + randn(N,1)*80);
Kredi(Kredi > 1900) = 1900; Kredi(Kredi < 0) = 0;

%% ADIM 4 (DÜZELTİLMİŞ): FİLTRELİ PORTFÖY DAĞILIMI (Zero-Inflation Model)

% 1. TOPLAM YATIRIM YAPILABİLİR SERVET
Birikim_Carpani = 2 + (Yas - 20) * 0.5;
Birikim_Carpani(Birikim_Carpani < 1) = 1;
Birikim_Carpani(Meslek_Kod == 8 | Meslek_Kod == 10) = Birikim_Carpani(Meslek_Kod == 8 | Meslek_Kod == 10) * 3.0;
Birikim_Carpani(Meslek_Kod == 9) = Birikim_Carpani(Meslek_Kod == 9) * 2.0;
Toplam_Servet = Maas .* Birikim_Carpani .* lognrnd(0, 0.3, N, 1);

% =========================================================================
% YENİ KISIM: KATILIM FİLTRELERİ 
% =========================================================================

% A. HİSSE SENEDİ FİLTRESİ
% Türkiye'de borsa penetrasyonu düşüktür. Finansal okuryazarlık ister.
% Baz Olasılık: %5. Eğitim, Gelir ve Risk bunu artırır.
Prob_Hisse = 0.05 + ... 
             (Egitim_Kod >= 3) * 0.15 + ...     % Üniversite mezunu +%15
             (Meslek_Kod == 8) * 0.60 + ...     % Finansçı ise +%60 (neredeyse kesin)
             (Risk_Algisi >= 4) * 0.20 + ...    % Risk seven +%20
             (Is_Sege12) * 0.10;                % Büyükşehir +%10

Mask_Hisse = (rand(N, 1) < Prob_Hisse); % 1 veya 0 üretir

% B. KRİPTO FİLTRESİ
% Yaşlılar neredeyse hiç girmez. Gençler ve Erkekler ağırlıklı.
Prob_Kripto = 0.0 + ...
              (Yas < 35) * 0.40 + ...           % Gençse %40 şansla girer
              (Cinsiyet_Kod == 2) * 0.10 + ...  % Erkekse +%10
              (Risk_Algisi == 5) * 0.30;        % Risk hastasıysa +%30

Mask_Kripto = (rand(N, 1) < Prob_Kripto);

% C. FON FİLTRESİ (Yatırım Fonu / BES)
% Genelde beyaz yaka ve eğitimliler bilir.
Prob_Fon = 0.10 + (Egitim_Kod >= 3) * 0.30 + (Meslek_Kod == 4 | Meslek_Kod == 3) * 0.20;
Mask_Fon = (rand(N, 1) < Prob_Fon);

% D. EMTİA (ALTIN) FİLTRESİ
% Türkiye'de altın çok yaygındır ama yine de %100 değildir.
% Kadınlarda ve geleneksel kesimde yüksektir.
Prob_Emtia = 0.40 + (Cinsiyet_Kod == 1) * 0.20 + (Meslek_Kod == 10) * 0.40 + (Is_Sege56) * 0.20;
Mask_Emtia = (rand(N, 1) < Prob_Emtia);

% E. GAYRİMENKUL FİLTRESİ 
Mask_GM = (Toplam_Servet > 2000000);

% F. NAKİT FİLTRESİ
% Herkesin nakdi olur. Filtre yok
Mask_Nakit = true(N, 1); 

% =========================================================================
% 2. İSTEK SKORLARINI HESAPLAMA
% =========================================================================

% --- SKORLAR ---
Beta_Hisse_Sabit = -1.8; Beta_Hisse_Risk = 0.8; Beta_Hisse_Sege = 2.0; Beta_Hisse_Egitim= 1.5;
Skor_Hisse = Beta_Hisse_Sabit + (Risk_Algisi/5 * Beta_Hisse_Risk * 5) + (Is_Sege12 * Beta_Hisse_Sege) + ((Egitim_Kod >= 3) * Beta_Hisse_Egitim) + (Norm_Maas * 2.0);
Skor_Hisse(Skor_Hisse < 0) = 0;

Beta_GM_Sabit = -1.5; Beta_GM_Evli = 2.0; Beta_GM_Maas = 3.5; Beta_GM_Kredi = 2.5; Beta_GM_Yas = 1.5; Bonus_GM_Meslek = (Meslek_Kod == 9) * 5.0; 
Skor_GM = Beta_GM_Sabit + (Is_Evli * Beta_GM_Evli) + (Norm_Maas * Beta_GM_Maas) + ((Kredi >= 1200) * Beta_GM_Kredi) + ((Yas > 35) * Beta_GM_Yas) + Bonus_GM_Meslek;
Skor_GM(Skor_GM < 0) = 0;

Beta_Nakit_Sabit = 3.0; Beta_Nakit_Risk = -2.0; Beta_Nakit_Sege = 1.0;  
Skor_Nakit = Beta_Nakit_Sabit + (Risk_Algisi/5 * Beta_Nakit_Risk) + (Is_Sege56 * Beta_Nakit_Sege) + (Norm_Maas * -1.5); 
Skor_Nakit(Skor_Nakit < 0.1) = 0.1;

Skor_Kripto = -2.0 + ((Yas < 35)*3.0) + (Risk_Algisi/5 * 5.0);
Skor_Kripto(Skor_Kripto < 0) = 0;

Beta_Emtia_Sabit = 1.0; Beta_Emtia_Kuyumcu = 10.0; Beta_Emtia_Risk = -1.0; 
Skor_Emtia = Beta_Emtia_Sabit + ((Meslek_Kod == 10) * Beta_Emtia_Kuyumcu) + (Norm_Maas * 1.0) + (Risk_Algisi/5 * Beta_Emtia_Risk);
Skor_Emtia(Skor_Emtia < 0) = 0;

Skor_Fon = -1.0 + (Egitim_Kod >= 3)*2.0 + (Meslek_Kod == 4)*3.0;
Skor_Fon(Skor_Fon < 0) = 0;

% =========================================================================
% 3. KRİTİK ADIM: FİLTRELERİ UYGULAMA (MASKING)
% =========================================================================
% Eğer Maske 0 ise, Skor ne olursa olsun sonuç 0 olur.
Skor_Hisse  = Skor_Hisse .* Mask_Hisse;
Skor_GM     = Skor_GM    .* Mask_GM;
Skor_Kripto = Skor_Kripto .* Mask_Kripto;
Skor_Emtia  = Skor_Emtia .* Mask_Emtia;
Skor_Fon    = Skor_Fon   .* Mask_Fon;
% Nakit maskesi uygulamıyoruz, o her zaman var.

% 4. NORMALİZASYON VE DAĞITIM
Skor_Matris = [Skor_Hisse, Skor_GM, Skor_Nakit, Skor_Kripto, Skor_Emtia, Skor_Fon];
Toplam_Istah = sum(Skor_Matris, 2);
Toplam_Istah(Toplam_Istah == 0) = 1;

Agirliklar = Skor_Matris ./ Toplam_Istah;

Hisse   = round(Toplam_Servet .* Agirliklar(:,1));
GM      = round(Toplam_Servet .* Agirliklar(:,2));
Nakit   = round(Toplam_Servet .* Agirliklar(:,3));
Kripto  = round(Toplam_Servet .* Agirliklar(:,4));
Emtia   = round(Toplam_Servet .* Agirliklar(:,5));
Fon     = round(Toplam_Servet .* Agirliklar(:,6));

Toplam_Yatirim = Hisse + GM + Nakit + Kripto + Emtia + Fon;


%% Grafikler
figure('Name', '1. Sehir ve SEGE Dogrulamasi');
% Kutu Grafiği (Boxplot): Her SEGE grubunun maaş dağılımını gösterir
boxplot(Maas, Sege_Puan);

title('SEGE Gelişmişlik Düzeyine Göre Maaş Dağılımı');
xlabel('SEGE Grubu (1: En Gelişmiş - 6: En Az Gelişmiş)');
ylabel('Aylık Maaş (TL)');
grid on;

%%
figure('Name', '2. Cinsiyet Etkisi Dogrulamasi');
% Burada Emtia (Altın) sahipliği ortalamasını bar grafiği ile çiziyoruz.

X_Kategoriler = categorical({'Kadin', 'Erkek'});
Ortalama_Altin = [mean(Emtia(strcmp(Cinsiyet, 'Kadin'))), ...
                  mean(Emtia(strcmp(Cinsiyet, 'Erkek')))];

bar(X_Kategoriler, Ortalama_Altin);

title('Cinsiyete Göre Ortalama Altın (Emtia) Yatırımı');
ylabel('Ortalama Altın Yatırımı (TL)');
grid on;

%%
figure('Name', '3. Egitim Seviyesi ve Maas Etkisi');

% Boxplot (Kutu Grafiği) kullanıyoruz.
% Egitim_Kod: 1(İlköğretim) -> 4(Lisansüstü)
boxplot(Maas, Egitim_Kod);

% Eksen İsimlerini Kod Yerine Kelime Olarak Yazalım
set(gca, 'XTickLabel', {'Ilkogretim', 'Lise', 'Lisans', 'LisansUstu'});

title('Eğitim Seviyesine Göre Maaş Dağılımı');
xlabel('Eğitim Durumu');
ylabel('Aylık Maaş (TL)');
grid on;

%%
figure('Name', '4. Deneyim Yili ve Toplam Yatirim (Trend)');

% 1. Adım: Tüm veriyi tek seferde çiz (Scatter)
% MarkerFaceAlpha: Noktaları şeffaf yapar, böylece yoğunluk olan yerler koyu görünür.
s = scatter(Deneyim_Yil, Toplam_Yatirim, 20, 'filled', ...
       'MarkerFaceColor', [0.3 0.6 0.8], 'MarkerFaceAlpha', 0.4); 

hold on;

% 2. Adım: Trend Çizgisi (Linear Fit) - DÖNGÜSÜZ
% polyfit veriye en uygun doğruyu bulur (y = ax + b)
katsayilar = polyfit(Deneyim_Yil, Toplam_Yatirim, 1); 

% X ekseni boyunca çizgi değerlerini hesapla
x_degerleri = min(Deneyim_Yil):max(Deneyim_Yil);
y_trend = polyval(katsayilar, x_degerleri);

% Trendi çiz
plot(x_degerleri, y_trend, 'r-', 'LineWidth', 3);

% Görsel Ayarlar
title('İş Deneyiminin Toplam Varlığa Etkisi');
xlabel('Deneyim Yılı');
ylabel('Toplam Yatırım (TL)');
legend({'Yatırımcılar', 'Ortalama Artış Eğilimi'}, 'Location', 'northwest');
grid on;

% Not: Çok uç değerler (Milyarderler) grafiği basık göstermesin diye
% Y eksenini nüfusun %98'ini kapsayacak şekilde kırpıyoruz.
ylim([0, prctile(Toplam_Yatirim, 98)]); 

hold off;

%%
figure('Name', '5. Egitim ve Finansal Okuryazarlik (Borsa Katilimi)');

% Her eğitim grubu için Hisse Senedi tutanların oranını hesaplayalım
Hisse_Oranlari = zeros(1, 4);
for i = 1:4
    % (Hisse > 0) diyerek o grupta hissesi olanların yüzdesini alıyoruz
    Hisse_Oranlari(i) = mean(Hisse(Egitim_Kod == i) > 0) * 100;
end

bar(Hisse_Oranlari, 'FaceColor', [0.2 0.5 0.7]);
set(gca, 'XTickLabel', {'Ilkogretim', 'Lise', 'Lisans', 'LisansUstu'});

title('Eğitim Seviyesine Göre Borsa Yatırımcısı Oranı');
ylabel('Yatırımcı Oranı (%)');
grid on;

%%
figure('Name', '6. Mesleklere Gore Portfoy Dagilimi');

Meslek_Sayisi = 10; % Kodda 10 meslek tanimladik
Ortalama_Portfoy = zeros(Meslek_Sayisi, 5); % 5 Varlık sınıfı: Hisse, GM, Nakit, Kripto, Emtia (Fon hariç basit olsun)

for m = 1:Meslek_Sayisi
    idx = (Meslek_Kod == m);
    if sum(idx) > 0
        % O meslek grubunun ortalama varlıklarını al
        Ortalama_Portfoy(m, :) = mean([Hisse(idx), GM(idx), Nakit(idx), Kripto(idx), Emtia(idx)], 1);
    end
end

% Yığılmış (Stacked) Bar Grafiği
bar(1:Meslek_Sayisi, Ortalama_Portfoy, 'stacked');
legend({'Hisse', 'Emlak', 'Nakit', 'Kripto', 'Altın'}, 'Location', 'bestoutside');

% X Eksenine Meslek İsimlerini Yazalım
set(gca, 'XTick', 1:Meslek_Sayisi, 'XTickLabel', Meslek_Listesi);
xtickangle(45); % İsimler sığsın diye eğiyoruz

title('Meslek Gruplarının Ortalama Portföy Dağılımı');
ylabel('Ortalama Varlık Değeri (TL)');
grid on;

%%
figure('Name', '7. Risk Algisinin Yatirima Etkisi (Altin vs Hisse)');

Risk_Seviyeleri = 1:5;
Altin_Orani = zeros(1, 5);
Hisse_Orani = zeros(1, 5);

for r = Risk_Seviyeleri
    idx = (Risk_Algisi == r);
    % Kripto yerine Emtia (Altın) verisini çekiyoruz
    Altin_Orani(r) = mean(Emtia(idx) > 0) * 100;
    Hisse_Orani(r) = mean(Hisse(idx) > 0) * 100;
end

% Altın için Sarı/Turuncu, Hisse için Mavi renk kullanalım
plot(Risk_Seviyeleri, Altin_Orani, '-o', 'LineWidth', 2, 'Color', [0.85 0.6 0.1], 'DisplayName', 'Altın Sahipliği');
hold on;
plot(Risk_Seviyeleri, Hisse_Orani, '-s', 'LineWidth', 2, 'Color', [0.2 0.5 0.8], 'DisplayName', 'Hisse Senedi Sahipliği');

title('Risk Algısına Göre Varlık Tercihi: Güvenli Liman vs Borsa');
xlabel('Risk Algısı (1: Çok Garantici -> 5: Risk Seven)');
ylabel('Sahiplik Oranı (%)');
legend('show', 'Location', 'best'); % En uygun yere koyar
grid on;
hold off;

%%
figure('Name', '8. Maas ve Kredi Notu Iliskisi');

% Scatter (Saçılım) grafiği ile her bir kişiyi nokta olarak çiziyoruz
scatter(Maas, Kredi, 10, 'filled', 'MarkerFaceColor', [0.4 0.4 0.4], 'MarkerEdgeColor', 'none');

% Trend Çizgisi (Regresyon Doğrusu) Ekleyelim
h = lsline; 
set(h, 'LineWidth', 2, 'Color', 'r'); % Kırmızı trend çizgisi

title('Maaş ile Kredi Notu Arasındaki İlişki');
xlabel('Aylık Maaş (TL)');
ylabel('Kredi Notu (0-1900)');
grid on;

% Okunabilirliği artırmak için X eksenini limitleyebiliriz (Çok uç maaşlar grafiği bozmasın)
xlim([0, 150000]);