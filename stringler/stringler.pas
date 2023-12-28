unit stringler;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.StrUtils, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm5 = class(TForm)
    Edit1: TEdit;
    BtnCarp: TButton;
    Memo1: TMemo;
    BtnSil: TButton;
    BtnBul: TButton;
    BtnTersBul: TButton;
    BtnAralikBul: TButton;
    BtnSonluBul: TButton;
    BtnBasliBul: TButton;
    BtnTersSonBul: TButton;
    BtnTumunuBul: TButton;
    BtnAll: TButton;
    procedure BtnCarpClick(Sender: TObject);
    procedure BtnSilClick(Sender: TObject);
    procedure BtnBulClick(Sender: TObject);
    procedure BtnTersBulClick(Sender: TObject);
    procedure BtnAralikBulClick(Sender: TObject);
    procedure BtnSonluBulClick(Sender: TObject);
    procedure BtnBasliBulClick(Sender: TObject);
    procedure BtnTersSonBulClick(Sender: TObject);
    procedure BtnTumunuBulClick(Sender: TObject);
    procedure BtnAllClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

procedure TForm5.BtnCarpClick(Sender: TObject);

// String iþlemlerinde çarpma iþlemini yapmamýza olanak saðlar.
// Þart: 'deðer' * x formatýnda girilmelidir. (x herhangi bir tam sayý)
// Örneðin "'merhaba' * 3" yazdýðýmýz zaman "merhaba" deðerini ekrana 3 kere yazdýracak.
// "merhabamerhabamerhaba" þeklinde.

var
  s, actStr, actOperant, sonuc: string;
  i, startPos, endPos, sayi: Integer;
  NewValues: TArray<string>;
  values: TArray<string>;

begin
  s := Edit1.Text;

  s := Trim(s);

  if s.StartsWith('''') then
  begin
    startPos := 2;
    // Tek týrnak içindeki deðeri almak için baþlangýç pozisyonunu ayarla
    endPos := PosEx('''', s, startPos); // Tek týrnak kapanma pozisyonunu bul

    if endPos > 0 then
      actStr := Copy(s, startPos, endPos - startPos)
      // Tek týrnak içindeki deðeri al
    else
      actStr := '';

    startPos := endPos + 1; // Sonraki bölümün baþlangýç pozisyonunu güncelle
    s := Copy(s, startPos, Length(s)); // Tek týrnaktan sonraki bölümü al
  end
  else
  begin
    ShowMessage('Lütfen tek týrnak ile baþlayan string bir deðer giriniz');
  end;

  s := Trim(s);

  values := s.Split([' ']);
  // Boþluklara göre bölüp her bir deðeri baþka bir deðiþkene atayalým

  SetLength(NewValues, Length(values));
  // Yeni deðerleri saklamak için dizi boyutunu ayarla

  for i := 0 to Length(values) - 1 do
    NewValues[i] := values[i]; // Her bir deðeri baþka bir deðiþkene atayalým

  sayi := NewValues[1].ToInteger;

  if NewValues[0] = '*' then
  begin
    sonuc := DupeString(actStr, sayi);
  end;

  Memo1.Lines.Add('Sonuç: ' + sonuc);

end;

procedure TForm5.BtnAralikBulClick(Sender: TObject);

// String iþlemlerinde aralýklý deðer arama iþlemi yapmamýza olanak saðlar.
// Þart: Týrnak içindeki string deðeri içinde, köþeli parantez içinde belirtilen
// geçerli bir indeks aralýðýndaki karakterleri bulur.Ama son karakteri almaz.
// Þart 2: Köþeli parantez içine girilen indeksler ":" ile ayrýlmalýdýr.
// Ýndeks, 1'den baþlar, yani ilk karakterin indeksi 1'dir.
// Örneðin, "'merhaba'[2:4]" ifadesi kullanýldýðýnda, "merhaba" stringindeki
// 2. indeks ile (2. indeks dahil) 4. indeks arasýnda (4. indeks dahil deðil) olan "er" karakterlerini döndürür.

var
  s, actStr, actYer, actOperant, sonuc: string;
  i, startPos, endPos, startpar, endpar, startRange, endRange: Integer;
begin
  s := Edit1.Text;

  s := Trim(s);

  if s.StartsWith('''') then
  begin
    startPos := 2;
    // Tek týrnak içindeki deðeri almak için baþlangýç pozisyonunu ayarla
    endPos := PosEx('''', s, startPos); // Tek týrnak kapanma pozisyonunu bul

    if endPos > 0 then
      actStr := Copy(s, startPos, endPos - startPos)
      // Tek týrnak içindeki deðeri al
    else
      actStr := '';

    startPos := endPos + 1; // Sonraki bölümün baþlangýç pozisyonunu güncelle
    s := Copy(s, startPos, Length(s)); // Tek týrnaktan sonraki bölümü al
  end
  else
  begin
    ShowMessage('Lütfen tek týrnak ile baþlayan string bir deðer giriniz');
    Exit;
  end;

  s := Trim(s);

  if s.StartsWith('[') and s.EndsWith(']') then
  begin
    startpar := 2;
    // Köþeli parantez içindeki deðeri almak için baþlangýç pozisyonunu ayarla
    endpar := PosEx(']', s, startpar);
    // Köþeli parantez kapanma pozisyonunu bul

    if endpar > 0 then
      actYer := Copy(s, startpar, endpar - startpar)
      // Köþeli parantez içindeki deðeri al
    else
      actYer := '';
  end;

  if (actYer <> '') then
  begin
    // Köþeli parantez içindeki aralýðý kontrol et
    if Pos(':', actYer) > 0 then
    begin
      // Köþeli parantez içinde aralýk belirtilmiþ
      startRange := StrToIntDef(Copy(actYer, 1, Pos(':', actYer) - 1), 0);
      endRange := StrToIntDef(Copy(actYer, Pos(':', actYer) + 1,
        Length(actYer)), 0);

      if (startRange > 0) and (endRange > startRange) and
        (endRange <= Length(actStr)) then
      begin
        Memo1.Lines.Add('Sonuç: ' + Copy(actStr, startRange,
          endRange - startRange));
      end
      else
      begin
        ShowMessage('Geçersiz aralýk');
      end;
    end;
    // else
    // begin
    // // Köþeli parantez içinde tek bir indeks belirtilmiþ
    // if (StrToIntDef(actYer, 0) > 0) and
    // (StrToIntDef(actYer, 0) <= Length(actStr)) then
    // begin
    // Memo1.Lines.Add('Sonuç: ' + actStr[StrToInt(actYer)]);
    // end
    // else
    // begin
    // ShowMessage('Geçersiz indeks');
    // end;
    // end;
  end
  else
  begin
    ShowMessage('Geçersiz format');
  end;

end;

procedure TForm5.BtnBasliBulClick(Sender: TObject);

// String iþlemlerinde aralýklý deðer arama iþlemi yapmamýza olanak saðlar.
// Þart: Týrnak içindeki string deðeri içinde, köþeli parantez içinde belirtilen
// geçerli indeksten itibaren strin deðerin sonuna kadar olan karakterleri bulur.
// Þart 2: Köþeli parantez içine girilen indeksler ":" ile ayrýlmalýdýr.
// Ýndeks, 1'den baþlar, yani ilk karakterin indeksi 1'dir.
// Örneðin, "'merhaba'[3:]" ifadesi kullanýldýðýnda, "merhaba" stringindeki
// 3. indeksten itiabren string deðerin sonuna kadar olan "rhaba" karakterlerini döndürür.

var
  s, actStr, actYer, actOperant, sonuc: string;
  i, startPos, endPos, startpar, endpar, startRange, endRange: Integer;
begin
  s := Edit1.Text;

  s := Trim(s);

  if s.StartsWith('''') then
  begin
    startPos := 2;
    // Tek týrnak içindeki deðeri almak için baþlangýç pozisyonunu ayarla
    endPos := PosEx('''', s, startPos); // Tek týrnak kapanma pozisyonunu bul

    if endPos > 0 then
      actStr := Copy(s, startPos, endPos - startPos)
      // Tek týrnak içindeki deðeri al
    else
      actStr := '';

    startPos := endPos + 1; // Sonraki bölümün baþlangýç pozisyonunu güncelle
    s := Copy(s, startPos, Length(s)); // Tek týrnaktan sonraki bölümü al
  end
  else
  begin
    ShowMessage('Lütfen tek týrnak ile baþlayan string bir deðer giriniz');
    Exit;
  end;

  s := Trim(s);

  if s.StartsWith('[') and s.EndsWith(']') then
  begin
    startpar := 2;
    // Köþeli parantez içindeki deðeri almak için baþlangýç pozisyonunu ayarla
    endpar := PosEx(']', s, startpar);
    // Köþeli parantez kapanma pozisyonunu bul

    if endpar > 0 then
      actYer := Copy(s, startpar, endpar - startpar)
      // Köþeli parantez içindeki deðeri al
    else
      actYer := '';
  end;

  if (actYer <> '') then
  begin
    // Köþeli parantez içindeki aralýðý kontrol et
    if Pos(':', actYer) > 0 then
    begin
      // Köþeli parantez içinde aralýk belirtilmiþ
      startRange := StrToIntDef(Copy(actYer, 1, Pos(':', actYer) - 1), 0);

      if (startRange >= 0) then
      begin
        Memo1.Lines.Add('Sonuç1: ' + Copy(actStr, startRange, Length(actStr)));
      end
      else
      begin
        ShowMessage('Geçersiz aralýk');
      end;
    end;
  end
  else
  begin
    ShowMessage('Geçersiz format');
  end;
end;

procedure TForm5.BtnBulClick(Sender: TObject);

// String iþlemlerinde deðer arama iþlemi yapmamýza olanak saðlar.
// Þart: Týrnak içindeki string deðeri içinde, köþeli parantez içinde belirtilen geçerli bir indeksteki karakteri bulur.
// Ýndeks, 1'den baþlar, yani ilk karakterin indeksi 1'dir.
// Örneðin, "'merhaba'[3]" ifadesi kullanýldýðýnda, "merhaba" stringindeki 3. indeks (yani üçüncü karakter) olan "r" karakterini döndürür.

var
  s, actStr, actYer, actOperant, sonuc: string;
  i, startPos, endPos, startpar, endpar: Integer;
begin
  s := Edit1.Text;

  s := Trim(s);

  if s.StartsWith('''') then
  begin
    startPos := 2;
    // Tek týrnak içindeki deðeri almak için baþlangýç pozisyonunu ayarla
    endPos := PosEx('''', s, startPos); // Tek týrnak kapanma pozisyonunu bul

    if endPos > 0 then
      actStr := Copy(s, startPos, endPos - startPos)
      // Tek týrnak içindeki deðeri al
    else
      actStr := '';

    startPos := endPos + 1; // Sonraki bölümün baþlangýç pozisyonunu güncelle
    s := Copy(s, startPos, Length(s)); // Tek týrnaktan sonraki bölümü al
  end
  else
  begin
    ShowMessage('Lütfen tek týrnak ile baþlayan string bir deðer giriniz');
    Exit;
  end;

  s := Trim(s);

  if s.StartsWith('[') and s.EndsWith(']') then
  begin
    startpar := 2;
    // Tek týrnak içindeki deðeri almak için baþlangýç pozisyonunu ayarla
    endpar := PosEx(']', s, startpar); // Tek týrnak kapanma pozisyonunu bul

    if endpar > 0 then
      actYer := Copy(s, startpar, endpar - startpar)
      // Tek týrnak içindeki deðeri al
    else
      actYer := '';
  end;

  if (actYer <> '') and (StrToIntDef(actYer, 0) > 0) and
    (StrToIntDef(actYer, 0) <= Length(actStr)) then
  begin
    Memo1.Lines.Add('Sonuç: ' + actStr[StrToInt(actYer)]);
  end
  else
  begin
    ShowMessage('Geçersiz indeks');
  end;

end;

procedure TForm5.BtnSilClick(Sender: TObject);
begin
  Edit1.Clear;
  Memo1.Lines.Clear;
end;

procedure TForm5.BtnSonluBulClick(Sender: TObject);

// String iþlemlerinde aralýklý deðer arama iþlemi yapmamýza olanak saðlar.
// Þart: Týrnak içindeki string deðeri içinde, köþeli parantez içinde belirtilen
// geçerli indeks ile 1. indeks aralýðýndaki karakterleri bulur. Ama son karakteri almaz.
// Þart 2: Köþeli parantez içine girilen indeksler ":" ile ayrýlmalýdýr.
// Ýndeks, 1'den baþlar, yani ilk karakterin indeksi 1'dir.
// Örneðin, "'merhaba'[:4]" ifadesi kullanýldýðýnda, "merhaba" stringindeki
// 1. indeks ile (1. indeks dahil) 4. indeks arasýnda (4. indeks dahil deðil) olan "mer" karakterlerini döndürür.

var
  s, actStr, actYer, actOperant, sonuc: string;
  i, startPos, endPos, startpar, endpar, startRange, endRange: Integer;
begin
  s := Edit1.Text;

  s := Trim(s);

  if s.StartsWith('''') then
  begin
    startPos := 2;
    // Tek týrnak içindeki deðeri almak için baþlangýç pozisyonunu ayarla
    endPos := PosEx('''', s, startPos); // Tek týrnak kapanma pozisyonunu bul

    if endPos > 0 then
      actStr := Copy(s, startPos, endPos - startPos)
      // Tek týrnak içindeki deðeri al
    else
      actStr := '';

    startPos := endPos + 1; // Sonraki bölümün baþlangýç pozisyonunu güncelle
    s := Copy(s, startPos, Length(s)); // Tek týrnaktan sonraki bölümü al
  end
  else
  begin
    ShowMessage('Lütfen tek týrnak ile baþlayan string bir deðer giriniz');
    Exit;
  end;

  s := Trim(s);

  if s.StartsWith('[') and s.EndsWith(']') then
  begin
    startpar := 2;
    // Köþeli parantez içindeki deðeri almak için baþlangýç pozisyonunu ayarla
    endpar := PosEx(']', s, startpar);
    // Köþeli parantez kapanma pozisyonunu bul

    if endpar > 0 then
      actYer := Copy(s, startpar, endpar - startpar)
      // Köþeli parantez içindeki deðeri al
    else
      actYer := '';
  end;

  if (actYer <> '') then
  begin
    // Köþeli parantez içindeki aralýðý kontrol et
    if Pos(':', actYer) > 0 then
    begin
      // Köþeli parantez içinde aralýk belirtilmiþ
      startRange := StrToIntDef(Copy(actYer, 1, Pos(':', actYer) - 1), 0);
      endRange := StrToIntDef(Copy(actYer, Pos(':', actYer) + 1,
        Length(actYer)), 0);

      if (startRange = 0) and (endRange > startRange) and
        (endRange <= Length(actStr)) then
      begin
        Memo1.Lines.Add('Sonuç1: ' + Copy(actStr, startRange,
          endRange - startRange - 1));
      end
      else
      begin
        ShowMessage('Geçersiz aralýk');
      end;
    end;
  end
  else
  begin
    ShowMessage('Geçersiz format');
  end;
end;

procedure TForm5.BtnTersBulClick(Sender: TObject);

// String iþlemlerinde tersten deðer arama iþlemi yapmamýza olanak saðlar.
// Þart: Týrnak içindeki string deðeri içinde, köþeli parantez içinde belirtilen geçerli bir indeksteki karakteri bulur.
// Ýndeks, -1'den baþlar, yani son karakterin indeksi -1'dir.
// Örneðin, "'merhaba'[-3]" ifadesi kullanýldýðýnda, "merhaba" stringindeki -3. indeks (yani sondan üçüncü karakter) olan "a" karakterini döndürür.

var
  s, actStr, actYer, actOperant, sonuc: string;
  i, startPos, endPos, startpar, endpar: Integer;
begin
  s := Edit1.Text;

  s := Trim(s);

  if s.StartsWith('''') then
  begin
    startPos := 2;
    // Tek týrnak içindeki deðeri almak için baþlangýç pozisyonunu ayarla
    endPos := PosEx('''', s, startPos); // Tek týrnak kapanma pozisyonunu bul

    if endPos > 0 then
      actStr := Copy(s, startPos, endPos - startPos)
      // Tek týrnak içindeki deðeri al
    else
      actStr := '';

    startPos := endPos + 1; // Sonraki bölümün baþlangýç pozisyonunu güncelle
    s := Copy(s, startPos, Length(s)); // Tek týrnaktan sonraki bölümü al
  end
  else
  begin
    ShowMessage('Lütfen tek týrnak ile baþlayan string bir deðer giriniz');
    Exit;
  end;

  s := Trim(s);

  if s.StartsWith('[') and s.EndsWith(']') then
  begin
    startpar := 2;
    // Köþeli parantez içindeki deðeri almak için baþlangýç pozisyonunu ayarla
    endpar := PosEx(']', s, startpar);
    // Köþeli parantez kapanma pozisyonunu bul

    if endpar > 0 then
      actYer := Copy(s, startpar, endpar - startpar)
      // Köþeli parantez içindeki deðeri al
    else
      actYer := '';
  end;

  if (actYer <> '') then
  begin
    // Negatif indeksi kontrol et
    if actYer.StartsWith('-') then
    begin
      // Negatif indeksi düzelt
      actYer := Copy(actYer, 2, Length(actYer));
      if (StrToIntDef(actYer, 0) > 0) and
        (StrToIntDef(actYer, 0) <= Length(actStr)) then
      begin
        Memo1.Lines.Add('Sonuç: ' + actStr[Length(actStr) -
          StrToInt(actYer) + 1]);
      end
      else
      begin
        ShowMessage('Geçersiz indeks');
      end;
    end;
  end
  else
  begin
    ShowMessage('Geçersiz indeks');
  end;

end;

procedure TForm5.BtnTersSonBulClick(Sender: TObject);

// String iþlemlerinde aralýklý deðer arama iþlemi yapmamýza olanak saðlar.
// Þart: Týrnak içindeki string deðeri içinde, köþeli parantez içinde belirtilen
// geçerli bir indeks aralýðýndaki karakterleri bulur. Ýndeks aralýðý ":" ile ayrýlmalýdýr.
// Ýndeks, 1'den baþlar, yani ilk karakterin indeksi 1'dir.
// Örneðin, "'merhaba'[2:-2]" ifadesi kullanýldýðýnda, "merhaba" stringindeki
// 2. indeksten (2. indeks dahil) -2. indekse (sondan 2. indekse) kadar olan karakterleri yani "erha" kýsmýný döndürür.

var
  s, actStr, actYer, actOperant, sonuc: string;
  i, startPos, endPos, startpar, endpar, startRange, endRange: Integer;
begin
  s := Edit1.Text;

  s := Trim(s);

  if s.StartsWith('''') then
  begin
    startPos := 2;
    // Tek týrnak içindeki deðeri almak için baþlangýç pozisyonunu ayarla
    endPos := PosEx('''', s, startPos); // Tek týrnak kapanma pozisyonunu bul

    if endPos > 0 then
      actStr := Copy(s, startPos, endPos - startPos)
      // Tek týrnak içindeki deðeri al
    else
      actStr := '';

    startPos := endPos + 1; // Sonraki bölümün baþlangýç pozisyonunu güncelle
    s := Copy(s, startPos, Length(s)); // Tek týrnaktan sonraki bölümü al
  end
  else
  begin
    ShowMessage('Lütfen tek týrnak ile baþlayan string bir deðer giriniz');
    Exit;
  end;

  s := Trim(s);

  if s.StartsWith('[') and s.EndsWith(']') then
  begin
    startpar := 2;
    // Köþeli parantez içindeki deðeri almak için baþlangýç pozisyonunu ayarla
    endpar := PosEx(']', s, startpar);
    // Köþeli parantez kapanma pozisyonunu bul

    if endpar > 0 then
      actYer := Copy(s, startpar, endpar - startpar)
      // Köþeli parantez içindeki deðeri al
    else
      actYer := '';
  end;

  if (actYer <> '') then
  begin
    // Köþeli parantez içindeki aralýðý kontrol et
    if Pos(':', actYer) > 0 then
    begin
      // Köþeli parantez içinde aralýk belirtilmiþ
      startRange := StrToIntDef(Copy(actYer, 1, Pos(':', actYer) - 1), 0);

      if Pos(':', actYer) < Length(actYer) then
      begin
        if Copy(actYer, Pos(':', actYer) + 1, 1) = '-' then
          endRange := Length(actStr) +
            StrToIntDef(Copy(actYer, Pos(':', actYer) + 1, Length(actYer)), 0)
        else
          endRange := StrToIntDef(Copy(actYer, Pos(':', actYer) + 1,
            Length(actYer)), Length(actStr));
      end
      else
        endRange := Length(actStr);

      if (startRange >= 0) and (endRange >= startRange) and
        (endRange <= Length(actStr)) then
      begin
        Memo1.Lines.Add('Sonuç1: ' + Copy(actStr, startRange ,
          endRange - startRange + 1));
      end
      else
      begin
        ShowMessage('Geçersiz aralýk');
      end;
    end
  end
  else
  begin
    ShowMessage('Geçersiz format');
  end;
end;

procedure TForm5.BtnTumunuBulClick(Sender: TObject);

// String iþlemlerinde aralýklý deðer arama iþlemi yapmamýza olanak saðlar.
// Þart: Týrnak içine string deðeri, köþeli parantez içinede sadece ":" yazýlmalýdýr.
// Örneðin, "'merhaba'[:]" ifadesi kullanýldýðýnda, "merhaba" stringindeki
// tüm karakterleri ekrana döndürür. Yani merhaba deðerini döndürür.
var
  s, actStr, actYer, actOperant, sonuc: string;
  i, startPos, endPos, startpar, endpar, startRange, endRange: Integer;
begin
  s := Edit1.Text;

  s := Trim(s);

  if s.StartsWith('''') then
  begin
    startPos := 2;
    // Tek týrnak içindeki deðeri almak için baþlangýç pozisyonunu ayarla
    endPos := PosEx('''', s, startPos); // Tek týrnak kapanma pozisyonunu bul

    if endPos > 0 then
      actStr := Copy(s, startPos, endPos - startPos)
      // Tek týrnak içindeki deðeri al
    else
      actStr := '';

    startPos := endPos + 1; // Sonraki bölümün baþlangýç pozisyonunu güncelle
    s := Copy(s, startPos, Length(s)); // Tek týrnaktan sonraki bölümü al
  end
  else
  begin
    ShowMessage('Lütfen tek týrnak ile baþlayan string bir deðer giriniz');
    Exit;
  end;

  s := Trim(s);

  if s.StartsWith('[') and s.EndsWith(']') then
  begin
    startpar := 2;
    // Köþeli parantez içindeki deðeri almak için baþlangýç pozisyonunu ayarla
    endpar := PosEx(']', s, startpar);
    // Köþeli parantez kapanma pozisyonunu bul

    if endpar > 0 then
      actYer := Copy(s, startpar, endpar - startpar)
      // Köþeli parantez içindeki deðeri al
    else
      actYer := '';
  end;

  if (actYer <> '') then
  begin
    // Köþeli parantez içindeki aralýðý kontrol et
    if Pos(':', actYer) > 0 then
    begin
      // Köþeli parantez içinde aralýk belirtilmiþ
      startRange := StrToIntDef(Copy(actYer, 1, Pos(':', actYer) + 1), 0);

      if Pos(':', actYer) < Length(actYer) then
      begin
        if Copy(actYer, Pos(':', actYer) + 1, 1) = '-' then
          endRange := Length(actStr) +
            StrToIntDef(Copy(actYer, Pos(':', actYer) + 1, Length(actYer)), 0)
        else
          endRange := StrToIntDef(Copy(actYer, Pos(':', actYer) + 1,
            Length(actYer)), Length(actStr));
      end
      else
        endRange := Length(actStr);

      if (startRange >= 0) and (endRange >= startRange) and
        (endRange <= Length(actStr)) then
      begin
        Memo1.Lines.Add('Sonuç1: ' + Copy(actStr, startRange + 1,
          endRange - startRange));
      end
      else
      begin
        ShowMessage('Geçersiz aralýk');
      end;
    end
    else
    begin
      ShowMessage('Geçersiz indeks');
    end;
  end
  else
  begin
    ShowMessage('Geçersiz format');
  end;
end;


procedure TForm5.BtnAllClick(Sender: TObject);
var
  s, actStr, actYer, actOperant, sonuc: string;
  i, startPos, endPos, startpar, endpar, startRange, endRange: Integer;
begin
  s := Edit1.Text;

  s := Trim(s);

  if s.StartsWith('''') then
  begin
    startPos := 2;
    // Tek týrnak içindeki deðeri almak için baþlangýç pozisyonunu ayarla
    endPos := PosEx('''', s, startPos); // Tek týrnak kapanma pozisyonunu bul

    if endPos > 0 then
      actStr := Copy(s, startPos, endPos - startPos)
      // Tek týrnak içindeki deðeri al
    else
      actStr := '';

    startPos := endPos + 1; // Sonraki bölümün baþlangýç pozisyonunu güncelle
    s := Copy(s, startPos, Length(s)); // Tek týrnaktan sonraki bölümü al
  end
  else
  begin
    ShowMessage('Lütfen tek týrnak ile baþlayan string bir deðer giriniz');
    Exit;
  end;

  s := Trim(s);

  if s.StartsWith('[') and s.EndsWith(']') then
  begin
    startpar := 2;
    // Köþeli parantez içindeki deðeri almak için baþlangýç pozisyonunu ayarla
    endpar := PosEx(']', s, startpar);
    // Köþeli parantez kapanma pozisyonunu bul

    if endpar > 0 then
      actYer := Copy(s, startpar, endpar - startpar)
      // Köþeli parantez içindeki deðeri al
    else
      actYer := '';
  end;

  if (actYer <> '') then
  begin
    // Köþeli parantez içindeki aralýðý kontrol et
    if Pos(':', actYer) > 0 then
    begin
      // Köþeli parantez içinde aralýk belirtilmiþ
      startRange := StrToIntDef(Copy(actYer, 1, Pos(':', actYer) - 1), 1);

      if Pos(':', actYer) < Length(actYer) then
        endRange := StrToIntDef(Copy(actYer, Pos(':', actYer) + 1,
          Length(actYer)), Length(actStr))
      else
        endRange := Length(actStr);

      if (startRange >= 1) and (endRange > startRange) and
        (endRange <= Length(actStr)) then
      begin
        Memo1.Lines.Add('Sonuç1: ' + Copy(actStr, startRange , endRange - startRange ));
      end
      else
      begin
        ShowMessage('Geçersiz aralýk');
      end;

    end
    else if StrToIntDef(actYer, 0) <> 0 then
    begin
      // Köþeli parantez içinde tek bir indeks belirtilmiþ
      if (StrToIntDef(actYer, 0) > 0) and
        (StrToIntDef(actYer, 0) <= Length(actStr)) then
      begin
        Memo1.Lines.Add('Sonuç2: ' + actStr[StrToInt(actYer)]);
      end
      else if (StrToIntDef(actYer, 0) < 0) and
        (Abs(StrToIntDef(actYer, 0)) <= Length(actStr)) then
      begin
        Memo1.Lines.Add('Sonuç3: ' + actStr[Length(actStr) +
          StrToInt(actYer) + 1]);
      end
      else
      begin
        ShowMessage('Geçersiz indeks');
      end;
    end
    else
    begin
      ShowMessage('Geçersiz indeks');
    end;
  end
  else
  begin
    ShowMessage('Geçersiz format');
  end;
end;

end.
