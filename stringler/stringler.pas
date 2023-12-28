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

// String i�lemlerinde �arpma i�lemini yapmam�za olanak sa�lar.
// �art: 'de�er' * x format�nda girilmelidir. (x herhangi bir tam say�)
// �rne�in "'merhaba' * 3" yazd���m�z zaman "merhaba" de�erini ekrana 3 kere yazd�racak.
// "merhabamerhabamerhaba" �eklinde.

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
    // Tek t�rnak i�indeki de�eri almak i�in ba�lang�� pozisyonunu ayarla
    endPos := PosEx('''', s, startPos); // Tek t�rnak kapanma pozisyonunu bul

    if endPos > 0 then
      actStr := Copy(s, startPos, endPos - startPos)
      // Tek t�rnak i�indeki de�eri al
    else
      actStr := '';

    startPos := endPos + 1; // Sonraki b�l�m�n ba�lang�� pozisyonunu g�ncelle
    s := Copy(s, startPos, Length(s)); // Tek t�rnaktan sonraki b�l�m� al
  end
  else
  begin
    ShowMessage('L�tfen tek t�rnak ile ba�layan string bir de�er giriniz');
  end;

  s := Trim(s);

  values := s.Split([' ']);
  // Bo�luklara g�re b�l�p her bir de�eri ba�ka bir de�i�kene atayal�m

  SetLength(NewValues, Length(values));
  // Yeni de�erleri saklamak i�in dizi boyutunu ayarla

  for i := 0 to Length(values) - 1 do
    NewValues[i] := values[i]; // Her bir de�eri ba�ka bir de�i�kene atayal�m

  sayi := NewValues[1].ToInteger;

  if NewValues[0] = '*' then
  begin
    sonuc := DupeString(actStr, sayi);
  end;

  Memo1.Lines.Add('Sonu�: ' + sonuc);

end;

procedure TForm5.BtnAralikBulClick(Sender: TObject);

// String i�lemlerinde aral�kl� de�er arama i�lemi yapmam�za olanak sa�lar.
// �art: T�rnak i�indeki string de�eri i�inde, k��eli parantez i�inde belirtilen
// ge�erli bir indeks aral���ndaki karakterleri bulur.Ama son karakteri almaz.
// �art 2: K��eli parantez i�ine girilen indeksler ":" ile ayr�lmal�d�r.
// �ndeks, 1'den ba�lar, yani ilk karakterin indeksi 1'dir.
// �rne�in, "'merhaba'[2:4]" ifadesi kullan�ld���nda, "merhaba" stringindeki
// 2. indeks ile (2. indeks dahil) 4. indeks aras�nda (4. indeks dahil de�il) olan "er" karakterlerini d�nd�r�r.

var
  s, actStr, actYer, actOperant, sonuc: string;
  i, startPos, endPos, startpar, endpar, startRange, endRange: Integer;
begin
  s := Edit1.Text;

  s := Trim(s);

  if s.StartsWith('''') then
  begin
    startPos := 2;
    // Tek t�rnak i�indeki de�eri almak i�in ba�lang�� pozisyonunu ayarla
    endPos := PosEx('''', s, startPos); // Tek t�rnak kapanma pozisyonunu bul

    if endPos > 0 then
      actStr := Copy(s, startPos, endPos - startPos)
      // Tek t�rnak i�indeki de�eri al
    else
      actStr := '';

    startPos := endPos + 1; // Sonraki b�l�m�n ba�lang�� pozisyonunu g�ncelle
    s := Copy(s, startPos, Length(s)); // Tek t�rnaktan sonraki b�l�m� al
  end
  else
  begin
    ShowMessage('L�tfen tek t�rnak ile ba�layan string bir de�er giriniz');
    Exit;
  end;

  s := Trim(s);

  if s.StartsWith('[') and s.EndsWith(']') then
  begin
    startpar := 2;
    // K��eli parantez i�indeki de�eri almak i�in ba�lang�� pozisyonunu ayarla
    endpar := PosEx(']', s, startpar);
    // K��eli parantez kapanma pozisyonunu bul

    if endpar > 0 then
      actYer := Copy(s, startpar, endpar - startpar)
      // K��eli parantez i�indeki de�eri al
    else
      actYer := '';
  end;

  if (actYer <> '') then
  begin
    // K��eli parantez i�indeki aral��� kontrol et
    if Pos(':', actYer) > 0 then
    begin
      // K��eli parantez i�inde aral�k belirtilmi�
      startRange := StrToIntDef(Copy(actYer, 1, Pos(':', actYer) - 1), 0);
      endRange := StrToIntDef(Copy(actYer, Pos(':', actYer) + 1,
        Length(actYer)), 0);

      if (startRange > 0) and (endRange > startRange) and
        (endRange <= Length(actStr)) then
      begin
        Memo1.Lines.Add('Sonu�: ' + Copy(actStr, startRange,
          endRange - startRange));
      end
      else
      begin
        ShowMessage('Ge�ersiz aral�k');
      end;
    end;
    // else
    // begin
    // // K��eli parantez i�inde tek bir indeks belirtilmi�
    // if (StrToIntDef(actYer, 0) > 0) and
    // (StrToIntDef(actYer, 0) <= Length(actStr)) then
    // begin
    // Memo1.Lines.Add('Sonu�: ' + actStr[StrToInt(actYer)]);
    // end
    // else
    // begin
    // ShowMessage('Ge�ersiz indeks');
    // end;
    // end;
  end
  else
  begin
    ShowMessage('Ge�ersiz format');
  end;

end;

procedure TForm5.BtnBasliBulClick(Sender: TObject);

// String i�lemlerinde aral�kl� de�er arama i�lemi yapmam�za olanak sa�lar.
// �art: T�rnak i�indeki string de�eri i�inde, k��eli parantez i�inde belirtilen
// ge�erli indeksten itibaren strin de�erin sonuna kadar olan karakterleri bulur.
// �art 2: K��eli parantez i�ine girilen indeksler ":" ile ayr�lmal�d�r.
// �ndeks, 1'den ba�lar, yani ilk karakterin indeksi 1'dir.
// �rne�in, "'merhaba'[3:]" ifadesi kullan�ld���nda, "merhaba" stringindeki
// 3. indeksten itiabren string de�erin sonuna kadar olan "rhaba" karakterlerini d�nd�r�r.

var
  s, actStr, actYer, actOperant, sonuc: string;
  i, startPos, endPos, startpar, endpar, startRange, endRange: Integer;
begin
  s := Edit1.Text;

  s := Trim(s);

  if s.StartsWith('''') then
  begin
    startPos := 2;
    // Tek t�rnak i�indeki de�eri almak i�in ba�lang�� pozisyonunu ayarla
    endPos := PosEx('''', s, startPos); // Tek t�rnak kapanma pozisyonunu bul

    if endPos > 0 then
      actStr := Copy(s, startPos, endPos - startPos)
      // Tek t�rnak i�indeki de�eri al
    else
      actStr := '';

    startPos := endPos + 1; // Sonraki b�l�m�n ba�lang�� pozisyonunu g�ncelle
    s := Copy(s, startPos, Length(s)); // Tek t�rnaktan sonraki b�l�m� al
  end
  else
  begin
    ShowMessage('L�tfen tek t�rnak ile ba�layan string bir de�er giriniz');
    Exit;
  end;

  s := Trim(s);

  if s.StartsWith('[') and s.EndsWith(']') then
  begin
    startpar := 2;
    // K��eli parantez i�indeki de�eri almak i�in ba�lang�� pozisyonunu ayarla
    endpar := PosEx(']', s, startpar);
    // K��eli parantez kapanma pozisyonunu bul

    if endpar > 0 then
      actYer := Copy(s, startpar, endpar - startpar)
      // K��eli parantez i�indeki de�eri al
    else
      actYer := '';
  end;

  if (actYer <> '') then
  begin
    // K��eli parantez i�indeki aral��� kontrol et
    if Pos(':', actYer) > 0 then
    begin
      // K��eli parantez i�inde aral�k belirtilmi�
      startRange := StrToIntDef(Copy(actYer, 1, Pos(':', actYer) - 1), 0);

      if (startRange >= 0) then
      begin
        Memo1.Lines.Add('Sonu�1: ' + Copy(actStr, startRange, Length(actStr)));
      end
      else
      begin
        ShowMessage('Ge�ersiz aral�k');
      end;
    end;
  end
  else
  begin
    ShowMessage('Ge�ersiz format');
  end;
end;

procedure TForm5.BtnBulClick(Sender: TObject);

// String i�lemlerinde de�er arama i�lemi yapmam�za olanak sa�lar.
// �art: T�rnak i�indeki string de�eri i�inde, k��eli parantez i�inde belirtilen ge�erli bir indeksteki karakteri bulur.
// �ndeks, 1'den ba�lar, yani ilk karakterin indeksi 1'dir.
// �rne�in, "'merhaba'[3]" ifadesi kullan�ld���nda, "merhaba" stringindeki 3. indeks (yani ���nc� karakter) olan "r" karakterini d�nd�r�r.

var
  s, actStr, actYer, actOperant, sonuc: string;
  i, startPos, endPos, startpar, endpar: Integer;
begin
  s := Edit1.Text;

  s := Trim(s);

  if s.StartsWith('''') then
  begin
    startPos := 2;
    // Tek t�rnak i�indeki de�eri almak i�in ba�lang�� pozisyonunu ayarla
    endPos := PosEx('''', s, startPos); // Tek t�rnak kapanma pozisyonunu bul

    if endPos > 0 then
      actStr := Copy(s, startPos, endPos - startPos)
      // Tek t�rnak i�indeki de�eri al
    else
      actStr := '';

    startPos := endPos + 1; // Sonraki b�l�m�n ba�lang�� pozisyonunu g�ncelle
    s := Copy(s, startPos, Length(s)); // Tek t�rnaktan sonraki b�l�m� al
  end
  else
  begin
    ShowMessage('L�tfen tek t�rnak ile ba�layan string bir de�er giriniz');
    Exit;
  end;

  s := Trim(s);

  if s.StartsWith('[') and s.EndsWith(']') then
  begin
    startpar := 2;
    // Tek t�rnak i�indeki de�eri almak i�in ba�lang�� pozisyonunu ayarla
    endpar := PosEx(']', s, startpar); // Tek t�rnak kapanma pozisyonunu bul

    if endpar > 0 then
      actYer := Copy(s, startpar, endpar - startpar)
      // Tek t�rnak i�indeki de�eri al
    else
      actYer := '';
  end;

  if (actYer <> '') and (StrToIntDef(actYer, 0) > 0) and
    (StrToIntDef(actYer, 0) <= Length(actStr)) then
  begin
    Memo1.Lines.Add('Sonu�: ' + actStr[StrToInt(actYer)]);
  end
  else
  begin
    ShowMessage('Ge�ersiz indeks');
  end;

end;

procedure TForm5.BtnSilClick(Sender: TObject);
begin
  Edit1.Clear;
  Memo1.Lines.Clear;
end;

procedure TForm5.BtnSonluBulClick(Sender: TObject);

// String i�lemlerinde aral�kl� de�er arama i�lemi yapmam�za olanak sa�lar.
// �art: T�rnak i�indeki string de�eri i�inde, k��eli parantez i�inde belirtilen
// ge�erli indeks ile 1. indeks aral���ndaki karakterleri bulur. Ama son karakteri almaz.
// �art 2: K��eli parantez i�ine girilen indeksler ":" ile ayr�lmal�d�r.
// �ndeks, 1'den ba�lar, yani ilk karakterin indeksi 1'dir.
// �rne�in, "'merhaba'[:4]" ifadesi kullan�ld���nda, "merhaba" stringindeki
// 1. indeks ile (1. indeks dahil) 4. indeks aras�nda (4. indeks dahil de�il) olan "mer" karakterlerini d�nd�r�r.

var
  s, actStr, actYer, actOperant, sonuc: string;
  i, startPos, endPos, startpar, endpar, startRange, endRange: Integer;
begin
  s := Edit1.Text;

  s := Trim(s);

  if s.StartsWith('''') then
  begin
    startPos := 2;
    // Tek t�rnak i�indeki de�eri almak i�in ba�lang�� pozisyonunu ayarla
    endPos := PosEx('''', s, startPos); // Tek t�rnak kapanma pozisyonunu bul

    if endPos > 0 then
      actStr := Copy(s, startPos, endPos - startPos)
      // Tek t�rnak i�indeki de�eri al
    else
      actStr := '';

    startPos := endPos + 1; // Sonraki b�l�m�n ba�lang�� pozisyonunu g�ncelle
    s := Copy(s, startPos, Length(s)); // Tek t�rnaktan sonraki b�l�m� al
  end
  else
  begin
    ShowMessage('L�tfen tek t�rnak ile ba�layan string bir de�er giriniz');
    Exit;
  end;

  s := Trim(s);

  if s.StartsWith('[') and s.EndsWith(']') then
  begin
    startpar := 2;
    // K��eli parantez i�indeki de�eri almak i�in ba�lang�� pozisyonunu ayarla
    endpar := PosEx(']', s, startpar);
    // K��eli parantez kapanma pozisyonunu bul

    if endpar > 0 then
      actYer := Copy(s, startpar, endpar - startpar)
      // K��eli parantez i�indeki de�eri al
    else
      actYer := '';
  end;

  if (actYer <> '') then
  begin
    // K��eli parantez i�indeki aral��� kontrol et
    if Pos(':', actYer) > 0 then
    begin
      // K��eli parantez i�inde aral�k belirtilmi�
      startRange := StrToIntDef(Copy(actYer, 1, Pos(':', actYer) - 1), 0);
      endRange := StrToIntDef(Copy(actYer, Pos(':', actYer) + 1,
        Length(actYer)), 0);

      if (startRange = 0) and (endRange > startRange) and
        (endRange <= Length(actStr)) then
      begin
        Memo1.Lines.Add('Sonu�1: ' + Copy(actStr, startRange,
          endRange - startRange - 1));
      end
      else
      begin
        ShowMessage('Ge�ersiz aral�k');
      end;
    end;
  end
  else
  begin
    ShowMessage('Ge�ersiz format');
  end;
end;

procedure TForm5.BtnTersBulClick(Sender: TObject);

// String i�lemlerinde tersten de�er arama i�lemi yapmam�za olanak sa�lar.
// �art: T�rnak i�indeki string de�eri i�inde, k��eli parantez i�inde belirtilen ge�erli bir indeksteki karakteri bulur.
// �ndeks, -1'den ba�lar, yani son karakterin indeksi -1'dir.
// �rne�in, "'merhaba'[-3]" ifadesi kullan�ld���nda, "merhaba" stringindeki -3. indeks (yani sondan ���nc� karakter) olan "a" karakterini d�nd�r�r.

var
  s, actStr, actYer, actOperant, sonuc: string;
  i, startPos, endPos, startpar, endpar: Integer;
begin
  s := Edit1.Text;

  s := Trim(s);

  if s.StartsWith('''') then
  begin
    startPos := 2;
    // Tek t�rnak i�indeki de�eri almak i�in ba�lang�� pozisyonunu ayarla
    endPos := PosEx('''', s, startPos); // Tek t�rnak kapanma pozisyonunu bul

    if endPos > 0 then
      actStr := Copy(s, startPos, endPos - startPos)
      // Tek t�rnak i�indeki de�eri al
    else
      actStr := '';

    startPos := endPos + 1; // Sonraki b�l�m�n ba�lang�� pozisyonunu g�ncelle
    s := Copy(s, startPos, Length(s)); // Tek t�rnaktan sonraki b�l�m� al
  end
  else
  begin
    ShowMessage('L�tfen tek t�rnak ile ba�layan string bir de�er giriniz');
    Exit;
  end;

  s := Trim(s);

  if s.StartsWith('[') and s.EndsWith(']') then
  begin
    startpar := 2;
    // K��eli parantez i�indeki de�eri almak i�in ba�lang�� pozisyonunu ayarla
    endpar := PosEx(']', s, startpar);
    // K��eli parantez kapanma pozisyonunu bul

    if endpar > 0 then
      actYer := Copy(s, startpar, endpar - startpar)
      // K��eli parantez i�indeki de�eri al
    else
      actYer := '';
  end;

  if (actYer <> '') then
  begin
    // Negatif indeksi kontrol et
    if actYer.StartsWith('-') then
    begin
      // Negatif indeksi d�zelt
      actYer := Copy(actYer, 2, Length(actYer));
      if (StrToIntDef(actYer, 0) > 0) and
        (StrToIntDef(actYer, 0) <= Length(actStr)) then
      begin
        Memo1.Lines.Add('Sonu�: ' + actStr[Length(actStr) -
          StrToInt(actYer) + 1]);
      end
      else
      begin
        ShowMessage('Ge�ersiz indeks');
      end;
    end;
  end
  else
  begin
    ShowMessage('Ge�ersiz indeks');
  end;

end;

procedure TForm5.BtnTersSonBulClick(Sender: TObject);

// String i�lemlerinde aral�kl� de�er arama i�lemi yapmam�za olanak sa�lar.
// �art: T�rnak i�indeki string de�eri i�inde, k��eli parantez i�inde belirtilen
// ge�erli bir indeks aral���ndaki karakterleri bulur. �ndeks aral��� ":" ile ayr�lmal�d�r.
// �ndeks, 1'den ba�lar, yani ilk karakterin indeksi 1'dir.
// �rne�in, "'merhaba'[2:-2]" ifadesi kullan�ld���nda, "merhaba" stringindeki
// 2. indeksten (2. indeks dahil) -2. indekse (sondan 2. indekse) kadar olan karakterleri yani "erha" k�sm�n� d�nd�r�r.

var
  s, actStr, actYer, actOperant, sonuc: string;
  i, startPos, endPos, startpar, endpar, startRange, endRange: Integer;
begin
  s := Edit1.Text;

  s := Trim(s);

  if s.StartsWith('''') then
  begin
    startPos := 2;
    // Tek t�rnak i�indeki de�eri almak i�in ba�lang�� pozisyonunu ayarla
    endPos := PosEx('''', s, startPos); // Tek t�rnak kapanma pozisyonunu bul

    if endPos > 0 then
      actStr := Copy(s, startPos, endPos - startPos)
      // Tek t�rnak i�indeki de�eri al
    else
      actStr := '';

    startPos := endPos + 1; // Sonraki b�l�m�n ba�lang�� pozisyonunu g�ncelle
    s := Copy(s, startPos, Length(s)); // Tek t�rnaktan sonraki b�l�m� al
  end
  else
  begin
    ShowMessage('L�tfen tek t�rnak ile ba�layan string bir de�er giriniz');
    Exit;
  end;

  s := Trim(s);

  if s.StartsWith('[') and s.EndsWith(']') then
  begin
    startpar := 2;
    // K��eli parantez i�indeki de�eri almak i�in ba�lang�� pozisyonunu ayarla
    endpar := PosEx(']', s, startpar);
    // K��eli parantez kapanma pozisyonunu bul

    if endpar > 0 then
      actYer := Copy(s, startpar, endpar - startpar)
      // K��eli parantez i�indeki de�eri al
    else
      actYer := '';
  end;

  if (actYer <> '') then
  begin
    // K��eli parantez i�indeki aral��� kontrol et
    if Pos(':', actYer) > 0 then
    begin
      // K��eli parantez i�inde aral�k belirtilmi�
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
        Memo1.Lines.Add('Sonu�1: ' + Copy(actStr, startRange ,
          endRange - startRange + 1));
      end
      else
      begin
        ShowMessage('Ge�ersiz aral�k');
      end;
    end
  end
  else
  begin
    ShowMessage('Ge�ersiz format');
  end;
end;

procedure TForm5.BtnTumunuBulClick(Sender: TObject);

// String i�lemlerinde aral�kl� de�er arama i�lemi yapmam�za olanak sa�lar.
// �art: T�rnak i�ine string de�eri, k��eli parantez i�inede sadece ":" yaz�lmal�d�r.
// �rne�in, "'merhaba'[:]" ifadesi kullan�ld���nda, "merhaba" stringindeki
// t�m karakterleri ekrana d�nd�r�r. Yani merhaba de�erini d�nd�r�r.
var
  s, actStr, actYer, actOperant, sonuc: string;
  i, startPos, endPos, startpar, endpar, startRange, endRange: Integer;
begin
  s := Edit1.Text;

  s := Trim(s);

  if s.StartsWith('''') then
  begin
    startPos := 2;
    // Tek t�rnak i�indeki de�eri almak i�in ba�lang�� pozisyonunu ayarla
    endPos := PosEx('''', s, startPos); // Tek t�rnak kapanma pozisyonunu bul

    if endPos > 0 then
      actStr := Copy(s, startPos, endPos - startPos)
      // Tek t�rnak i�indeki de�eri al
    else
      actStr := '';

    startPos := endPos + 1; // Sonraki b�l�m�n ba�lang�� pozisyonunu g�ncelle
    s := Copy(s, startPos, Length(s)); // Tek t�rnaktan sonraki b�l�m� al
  end
  else
  begin
    ShowMessage('L�tfen tek t�rnak ile ba�layan string bir de�er giriniz');
    Exit;
  end;

  s := Trim(s);

  if s.StartsWith('[') and s.EndsWith(']') then
  begin
    startpar := 2;
    // K��eli parantez i�indeki de�eri almak i�in ba�lang�� pozisyonunu ayarla
    endpar := PosEx(']', s, startpar);
    // K��eli parantez kapanma pozisyonunu bul

    if endpar > 0 then
      actYer := Copy(s, startpar, endpar - startpar)
      // K��eli parantez i�indeki de�eri al
    else
      actYer := '';
  end;

  if (actYer <> '') then
  begin
    // K��eli parantez i�indeki aral��� kontrol et
    if Pos(':', actYer) > 0 then
    begin
      // K��eli parantez i�inde aral�k belirtilmi�
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
        Memo1.Lines.Add('Sonu�1: ' + Copy(actStr, startRange + 1,
          endRange - startRange));
      end
      else
      begin
        ShowMessage('Ge�ersiz aral�k');
      end;
    end
    else
    begin
      ShowMessage('Ge�ersiz indeks');
    end;
  end
  else
  begin
    ShowMessage('Ge�ersiz format');
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
    // Tek t�rnak i�indeki de�eri almak i�in ba�lang�� pozisyonunu ayarla
    endPos := PosEx('''', s, startPos); // Tek t�rnak kapanma pozisyonunu bul

    if endPos > 0 then
      actStr := Copy(s, startPos, endPos - startPos)
      // Tek t�rnak i�indeki de�eri al
    else
      actStr := '';

    startPos := endPos + 1; // Sonraki b�l�m�n ba�lang�� pozisyonunu g�ncelle
    s := Copy(s, startPos, Length(s)); // Tek t�rnaktan sonraki b�l�m� al
  end
  else
  begin
    ShowMessage('L�tfen tek t�rnak ile ba�layan string bir de�er giriniz');
    Exit;
  end;

  s := Trim(s);

  if s.StartsWith('[') and s.EndsWith(']') then
  begin
    startpar := 2;
    // K��eli parantez i�indeki de�eri almak i�in ba�lang�� pozisyonunu ayarla
    endpar := PosEx(']', s, startpar);
    // K��eli parantez kapanma pozisyonunu bul

    if endpar > 0 then
      actYer := Copy(s, startpar, endpar - startpar)
      // K��eli parantez i�indeki de�eri al
    else
      actYer := '';
  end;

  if (actYer <> '') then
  begin
    // K��eli parantez i�indeki aral��� kontrol et
    if Pos(':', actYer) > 0 then
    begin
      // K��eli parantez i�inde aral�k belirtilmi�
      startRange := StrToIntDef(Copy(actYer, 1, Pos(':', actYer) - 1), 1);

      if Pos(':', actYer) < Length(actYer) then
        endRange := StrToIntDef(Copy(actYer, Pos(':', actYer) + 1,
          Length(actYer)), Length(actStr))
      else
        endRange := Length(actStr);

      if (startRange >= 1) and (endRange > startRange) and
        (endRange <= Length(actStr)) then
      begin
        Memo1.Lines.Add('Sonu�1: ' + Copy(actStr, startRange , endRange - startRange ));
      end
      else
      begin
        ShowMessage('Ge�ersiz aral�k');
      end;

    end
    else if StrToIntDef(actYer, 0) <> 0 then
    begin
      // K��eli parantez i�inde tek bir indeks belirtilmi�
      if (StrToIntDef(actYer, 0) > 0) and
        (StrToIntDef(actYer, 0) <= Length(actStr)) then
      begin
        Memo1.Lines.Add('Sonu�2: ' + actStr[StrToInt(actYer)]);
      end
      else if (StrToIntDef(actYer, 0) < 0) and
        (Abs(StrToIntDef(actYer, 0)) <= Length(actStr)) then
      begin
        Memo1.Lines.Add('Sonu�3: ' + actStr[Length(actStr) +
          StrToInt(actYer) + 1]);
      end
      else
      begin
        ShowMessage('Ge�ersiz indeks');
      end;
    end
    else
    begin
      ShowMessage('Ge�ersiz indeks');
    end;
  end
  else
  begin
    ShowMessage('Ge�ersiz format');
  end;
end;

end.
