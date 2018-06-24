unit CBtoDELunit;


interface

uses
	Winapi.Windows,Winapi.Messages,System.SysUtils,System.Variants,System.Classes,Vcl.Graphics,
	Vcl.Controls,Vcl.Forms,Vcl.Dialogs,Vcl.ExtCtrls,Vcl.StdCtrls,types,
  Vcl.Menus,  Vcl.Grids, Vcl.ComCtrls,RegularExpressions;

type
	TIntArray=array of Integer;

	TSymbolType=(symError=$00000000,

		symType=$01000000,symVoid=$01000001,symNumber=$01000002,symChar=$01000003,symInt=$01000004,symDouble=$01000005,symString=$01000006,symItem=$0100000A,
		symStruct=$0100000E,
		symSemicolon,
		symColon,
		symAnd,
		symOr,
		symPointer,
		symRef,

		symBAnd,
		symBOr,
		symBXor,
		symBNot,
		symComment,

		symBlock,symKBlock,symCBlock,symOperator=$02000000,symCommand=$02000001,
		symLabel=$02000002,symDelimiter=$02000003,symEnd=$02000004,symJump=$02000005,
		symQualifier,
		symReserved=$04000000,symFunction=$04000001,symVariable=$04000002,

		symArray=$40000000,symVar=$80000000,symAll=$FFFFFFFF);


	TSymbol=record
	public
		typ:TSymbolType;
		str:string;
		src:string;
		cmt:string;
		function typestr:string;
		function add(c:TSymbol):string;
		function addstr(s:string):string;
		function convstr: string;
		function convblock: string;
		procedure clear;
	end;
	PSymbol=^TSYmbol;
	TSymbolArray=array of TSymbol;

	TSymbols=record
		null:TSymbol;
		items:TSymbolArray;
		function add(s:TSymbol):Integer;
		function last:PSymbol;
		function clear:Integer;
		function count:Integer;
		function hi:Integer;
		function structureis(position:integer;arg: array of TSymbolType): boolean;
		function structure:string;
		function source:string;
		function getstring(Index:Integer):string;
		procedure putstring(Index:Integer;const s:string);
		property strings[Index:Integer]:string read getstring write putstring;

		function get(Index:Integer):TSymbol;
		procedure put(Index:Integer;const s:TSymbol);
		property item[Index:Integer]:TSymbol read get write put;default;

		//	  function del(i:Integer): Integer;
		//	  function ins(i:Integer): Integer;
		//	  function move(i:Integer): Integer;
	private
		function structureisstr(position:Integer;arg:TStringDynArray):Integer;
	end;

	TStringSelf=class(TStringList)
	public
		buf:string;
		function this:TStringList;
	end;

	TStringDynArrayHelper=record helper for TStringDynArray
		function add(s:string):Integer;
		function item(i:Integer):String;
		function stringselfcreate:TStringSelf;
		function load(f:string):boolean;
		function save(f:string):boolean;
		function getcount:Integer;
		procedure setcount(const i:Integer);
		function hi:Integer;
		property count:Integer read getcount write setcount;
	end;

	TGrid=class(TStringGrid)
	private
		constructor CreateEX(Origin:TStringGrid);
		procedure WMChar(var Msg:TWMChar);message WM_CHAR;
		procedure CutCopy(modecut:boolean);
		procedure KeyDown(var Key:Word;Shift:TShiftState);override;
		function Paste:TGridRect;
		procedure MouseDown(Button:TMouseButton;Shift:TShiftState;
			X,Y:Integer);override;
		function DoMouseWheelDown(Shift:TShiftState;MousePos:TPoint)
			:boolean;override;
		function DoMouseWheelUp(Shift:TShiftState;MousePos:TPoint)
			:boolean;override;
	published
		property InplaceEditor;

	end;


	TFormCBtoDEL=class(TForm)
		Panel1:TPanel;
		Panel2:TPanel;
		DEL:TRichEdit;
		CB:TRichEdit;
		Splitter1:TSplitter;
    PanelTop: TPanel;
		MainMenu1: TMainMenu;
		MConv: TMenuItem;
		MSave: TMenuItem;
		MLoad: TMenuItem;
		MCut: TMenuItem;
		MCopy: TMenuItem;
		MPaste: TMenuItem;
		LOG: TRichEdit;
		CG: TStringGrid;
	Splitter2: TSplitter;
	MFolder: TMenuItem;
    PopupMenu1: TPopupMenu;
    PConv: TMenuItem;
	PCut: TMenuItem;
	PCopy: TMenuItem;
    PPeste: TMenuItem;
    Mend: TMenuItem;
	N8: TMenuItem;
    PopupMenu2: TPopupMenu;
	MenuItem1: TMenuItem;
	MenuItem2: TMenuItem;
	MenuItem3: TMenuItem;
	MenuItem4: TMenuItem;
	MenuItem5: TMenuItem;
	MenuItem6: TMenuItem;
	MenuItem7: TMenuItem;
	MenuItem8: TMenuItem;
	MenuItem10: TMenuItem;
	MenuItem11: TMenuItem;
	MenuItem12: TMenuItem;
	MenuItem13: TMenuItem;
	MenuItem14: TMenuItem;
	MenuItem15: TMenuItem;
	MenuItem16: TMenuItem;
	MenuItem17: TMenuItem;
	MenuItem18: TMenuItem;
	MenuItem19: TMenuItem;
	Panel3: TPanel;
	Label2: TLabel;
	EditLineBlock: TEdit;
    Label1: TLabel;
	EditSet: TEdit;
    MRowDup: TMenuItem;
	MRowDel: TMenuItem;
	MDvrow: TMenuItem;
    MSet: TMenuItem;
    MFixed: TMenuItem;
    MLSource: TMenuItem;
    MLStruct: TMenuItem;
    ButtonOk: TButton;
    EditVarBlock: TEdit;
    Label3: TLabel;
	c01: TMenuItem;
	o01: TMenuItem;
		procedure MConvClick(Sender: TObject);
		procedure MSaveClick(Sender: TObject);
		procedure MLoadClick(Sender: TObject);
		procedure MCutClick(Sender: TObject);
		procedure MCopyClick(Sender: TObject);
		procedure MPasteClick(Sender: TObject);
		procedure MendClick(Sender: TObject);
		procedure FormCreate(Sender: TObject);
		procedure CGSetEditText(Sender: TObject; ACol, ARow: Integer;
		  const Value: string);
	procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
	procedure FormDestroy(Sender: TObject);
	procedure MFolderClick(Sender: TObject);
	procedure ButtonT0Click(Sender: TObject);
	procedure MenuItemGridClick(Sender: TObject);
	procedure MenuItemGrid2Click(Sender: TObject);
	procedure MRowDupClick(Sender: TObject);
	procedure MRowDelClick(Sender: TObject);
	procedure MSetClick(Sender: TObject);

	private
	public
	   inidir:String;
		function statements(breakchar:string):TSymbol;
	end;

function symget(var pos:pchar;str:pchar;strdeli:CHAR):TSymbolType;

var
	FormCBtoDEL:TFormCBtoDEL;
	Src        :String;
	lineblock:TStringDynArray;
	varblock:TStringDynArray;
	xs,ys,xw,yw:Integer;
	line,pline :Integer;
	b          :TButton;
	p          :pchar;
	pp         :pchar;
	dsrc       :STRING;
	s          :STRING;
	ss         :STRING;
	sss        :STRING;
	symtyp    :TSymbolType;
	modecell   :boolean;
	modesheet  :boolean;
	col,row    :Integer;
	indent     :Integer;
	ia         :TIntArray;
//	StrArray   :TArray<string>;
//	symArray   :TArray<TSymbol>;
	come       :STRING;
	dstt       :TSymbol;
	str        :STRING;
	varstr :STRING;      //変数宣言をためる
	conststr: string;    //定数宣言をためる
	宣言ブロック:boolean;

implementation

{$R *.dfm}

uses
	System.Generics.Collections,System.Generics.Defaults,strutils
	,IniFiles ,Masks,Clipbrd,dgridlib,utild;

const
	SYMMAXLEN=1024;
	NULLNULL =#0#0;
	CR       =#13;
	LF       =#10;
	CRLF     =#13#10;
	TAB      =#9;
	CHEAD=',入力,出力,宣言';

var PCol, PRow: Integer;


	Ini: TIniFile;
	filename:string;
	txtfile:string;
	csvfile:string;

	regmatchstr:TStringDynArray;


function TStringSelf.this:TStringList;
begin
	exit(self);
end;


function split(s:string;i:integer;d:string=' '):string;
begin
	result:=SplitString(s,d).item(i);
end;


procedure TFormCBtoDEL.ButtonT0Click(Sender: TObject);
begin
//	TGrid(CG).InplaceEditor.seltext:=TButton(Sender).Caption;
	CG.cells[CG.col,CG.row]:=CG.cells[CG.col,CG.row]+TButton(Sender).Caption;
end;

procedure TFormCBtoDEL.CGSetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
begin
//	CG.Options:=CG.Options-[goEditing];
	if CG.Canvas.TextWidth('aa'+Value)>CG.ColWidths[ACol] then CG.ColWidths[ACol]:=CG.Canvas.TextWidth('aa'+Value);
	if ARow=CG.RowCount-1 then CG.RowCount:=CG.RowCount+1;
	if ACol=CG.ColCount-1 then CG.ColCount:=CG.ColCount+1;
end;

procedure TFormCBtoDEL.FormCreate(Sender: TObject);
begin
	CG :=TGrid.CreateEX(CG);
//	CG.OnKeyDown:=CGKeyDown;
	MLoadClick(sender);
	PCol:=CG.Col;
	PRow:=CG.Row;


end;



procedure TFormCBtoDEL.FormDestroy(Sender: TObject);
begin
	Ini.WriteInteger( 'Form', 'Width', Width );
	Ini.WriteInteger( 'Form', 'Height', Height );
	Ini.WriteInteger( 'Form', 'PanelTop.Height', PanelTop.Height );


end;

function trimrightlen(const s,ts:string;var len:integer):string;
var
	i:integer;
	ei:integer;
	si:integer;
begin
	result:='';
	for i:=len downto 1 do begin
		if(Pos(S[i],ts)<>0)then continue;
		len:=i;

		break;
	end;
	if len=0 then exit; //すべて削除文字
	si:=1;
	result:=Copy(S,si,len-si+1);
end;



function indenttab:string;
begin
	result:=StringOfChar(TAB,indent);
end;

function indenttabplus:string;
begin
	inc(indent);
	result:=StringOfChar(TAB,indent);
end;

function indentstr(s:string):string;
begin
	result:=indenttab+s;
end;

function indentcr:string;
begin
	result:=CRLF+indenttab;
end;

function existstr(s,a,b:string):string;
begin
	if s<>'' then result:=a+s+b;
end;

function TFormCBtoDEL.statements(breakchar:string):TSymbol;
var
	sym :TSymbol;
	syms:TSymbols;
	psym:PSymbol;
	s宣言ブロック:boolean;
	イフ:boolean;

	function symbol:TSymbol;
	var
		t:TSymbolType;
		s:string;
		ret:string;
		buf        : array [0..1024] of CHAR;
		procedure get;
		begin
			pp:=p;
			t:=symget(p,buf,'''');
			s:=buf;
			if s='const' then t:=symQualifier;
//				if s='&' then t:=symQualifier else
//				if s='*' then t:=symQualifier ;
		end;
		procedure ifadd(tt:TSymbolType);
		begin
			if t<>tt then exit;
			ret:=s;
			get;
			ret:=ret+' '+s;
		end;
		procedure add(tt:TSymbolType);
		begin
			if t<>tt then exit;
			ret:=s;
			repeat
				if ret='' then ret:=s else ret:=ret+' '+s;
				get;
			until t<>tt;
			p:=pp;
			t:=tt;
		end;
	begin
		get;
		ret:=s;
//			ifadd(symQualifier);
		str:=ret;
		result.typ:=t;
		result.str:=ret;
		result.src:=ret;
	end;

	procedure symback;
	begin
		p:=pp;
	end;

	procedure symnext;
	begin
		sym:=symbol;
		psym:=syms.last;
	end;


	function reconstruct:string;
	var
		sym :TSymbol;
		stype :TSymbolType;
		dstt:STRING;
		strc:STRING;
		ssrc:STRING;
		param:TStringDynArray;
		pcnt1:integer;
		pcnt2:integer;
		pcnt3:integer;
		valname:STRING;
		valvar:STRING;
		i:integer;
		pos:integer;
		posstart:integer;
		bindent:integer;

		function gets(i:integer):string;   //
		begin
			result:=syms[i].str+syms[i].cmt;
		end;

		function getstr(i:integer):string;   //
		begin
			result:=syms[posstart+i].str+syms[posstart+i].cmt;
		end;
		function getsrc(i:integer):string;   //
		begin
			result:=syms[posstart+i].src+syms[posstart+i].cmt;
		end;

		function get(i:integer):string;   //
		begin
			inc(i,posstart);
			if syms[i].typ=symCBlock then begin
				result:='begin'+CRLF+gets(i)+'end';
				if not イフ then result:=result+';';

			end else if syms[i].typ=symKBlock then
				result:=' ( '+syms[i].str+' ) '+syms[i].cmt
			else
				result:=syms[i].convstr+syms[i].cmt;
		end;

		function incget(i:integer):string;   //一つ読んで進む
		begin
			result:=get(i);
			inc(pos);
		end;

		function incgetval(i:integer):string;   //一つ読んで進むブロック
		begin
			result:=syms[posstart+i].str;
			valname:=result;
			inc(pos);
		end;

		function incgetsrc(i:integer):string;   //一つ読んで進むブロック
		begin
			result:=syms[posstart+i].str;
			inc(pos);
		end;



		function cat(pos:integer):string;   //最後までくっつける 最後の；なし
		var i:integer;
		begin
			result:='';
			for i:=posstart+pos to syms.hi do begin
//					if (i=syms.hi)and(syms[i].str=';') then break;

				if result<>'' then result:=result+' ';
				result:=result+get(i-posstart);
			end;
//				result:=dtrimstring(result,' ;');
			result:=result.trimright([' ',';']);
		end;




		function inccat:string;   //最後までくっつける
		begin
			while pos<=syms.hi do begin
				if result<>'' then result:=result+' ';
				result:=result+incget(pos-posstart);
			end;
		end;

		function sis(a:string):integer;
		begin
			if trim(a)='' then exit(0);
			result:=syms.structureisstr(posstart,SplitString(a,'｜'));
		end;


		function replacegrid(var ret:string;var stype :TSymbolType):boolean;
		var c,r:integer;
		var par:string;
		var para:TStringDynArray;
		var rep,rep2:string;
		var vrv:string;
		var con:string;
		var s:string;
		var ns:string;
		const a=1;
		var b:integer;
		i:integer;
		var subc:integer;
		var subd:string;
		var subs:string;
		var subr:string;
		var inccnt:integer;


			procedure replace(var rep:string);
			var rc:integer;
			var c:integer;
			var rm:integer;
			var ri:integer;
			var rs:string;
			var rsd:string;
			regmtc: TMatchCollection;
			regmt: TMatch;
			regg: TGroup;

			function dele:boolean;
			begin
				if regmt.Value.indexof(s)<>0 then exit(false);
				result:=true;
			end;

			function setrs(const s,v:string):boolean;
			begin
				if regmt.Value.indexof(s)<>0 then exit(false);
				rs:=v;
				result:=true;
			end;

			begin
				regmtc:=TRegEx.Matches(rep,'%[a-zA-Z0-9\+]*%');
				rm:=0;
				rs:='';
				for rc:=0 to regmtc.Count-1 do begin
					regmt:=regmtc[rc];
					c:=dval(regmt.Value)-1;
					ri:=regmt.Index-1+rm;
					rsd:=rep.SubString(ri);
					if setrs('%CR%',CRLF) then else
					if setrs('%E%',indenttab+'end;') then else
					if setrs('%t%',TAB) then else
					if setrs('%i%',indenttab) then else
					if setrs('%i+%',indenttabplus) then else
					if setrs('%d%','') then
						rep:=trimrightlen(rep,'; ',ri)+rep.SubString(ri) else
					if setrs('%x',regmatchstr.item(c+1)) then else
					if setrs('%c',cat(c)) then pos:=syms.count else
					if setrs('%o',getstr(c)) then else
					if setrs('%s',getsrc(c)) then else
						setrs('%',get(c));

					rep:=rep.remove(ri,regmt.Length).insert(ri,rs);
					rm:=rm-regmt.Length+rs.length;
					if pos=syms.count then break;
				end;
			end;


		begin
			result:=false;
			for r := 1 to

			CG.RowCount do begin
				par:= CG.cells[1,r];
				para:=SplitString(par,'｜');
				rep:= CG.cells[2,r];
				vrv:= CG.cells[3,r];
				inccnt:=sis(par);
				if inccnt>0 then begin
					if MDvrow.Checked then CG.Selection:=TGridRect(Rect(1,r,3,r));

					replace(vrv);
					replace(rep);
					inc(pos,inccnt);

					if 宣言ブロック then begin
					end else begin
						if vrv.IndexOf('var')>0 then begin
							varstr:=vrv+CRLF;
						end;
					end;
//						if rep='' then begin
//							stype:=symVar;//追加無し
//							inc(pos); //;を飛ばす
//						end;
					ret:=rep;
					exit(true);
				end;
			end;
		end;

	begin
		dstt:='';
		come:='';
		strc:=syms.structure;
		ssrc:=syms.source;
		ssrc:=StringReplace(ssrc,CRLF,'',[rfReplaceAll]);
		ssrc:=StringReplace(ssrc,TAB,'',[rfReplaceAll]);
		if MLSource.Checked then LOG.Lines.add(indentstr(ssrc));
		if MLStruct.Checked then LOG.Lines.add(indentstr(strc));
		pos:=0;
		bindent:=indent;
		//ブロックに変換前を保存して再構成できるようにする
		try
		for i := 0 to syms.hi do begin
			if i<pos then continue;
			pos:=i;
			sym:=syms[i];
			s:=sym.convstr;
			if s=CRLF then begin
				posstart:=pos;
				continue;
			end;
			posstart:=pos;

			stype:=symVoid;
			valname:='';
			s:='';

			if replacegrid(s,stype) then begin
				stype:=stype;
			end else
			if sis('(*)')>0 then begin //
				s:=incget(0);
			end else
			if sis('{*}')>0 then begin //

				s:=incget(0);
				s:=s+';';
				if varstr<>'' then begin
					s:=indenttab+varstr+s;
					varstr:='';
				end;
			end else begin
				s:=incget(0);
			end;



			if stype=symVar then else
			if stype=symFunction then dstt:=dstt+s+';'+CRLF else
			if stype=symLabel then dstt:=dstt+s else
				dstt:=dstt+s+' ';
		end;
		except
//				dmessage(strc);
		end;



		for sym in syms.items do begin
		end;
		indent:=bindent;

		result:=dstt;
	end;

	function kakko:Integer;
	var
		sym :TSymbol;
		dstt:STRING;
	begin
		sym.typ:=symKBlock;
		while (p[0]<>#0) do begin
			sym.add(statements(')'));
			if str=';' then sym.addstr(' ');
			if str=')' then break;
			sym.str:=sym.str;
		end;
		syms.add(sym);
	end;

	procedure eq;
	var
		ssym: tsymbol;

		procedure addsub;
		var
			ssym: tsymbol;

			procedure andor;
			var
				ssym: tsymbol;

				procedure nott;
				var
					ssym: tsymbol;

					procedure compare;
					var
						ssym: tsymbol;

						procedure muldiv;
						var
							ssym: tsymbol;

							procedure factor;
							var
								ssym: tsymbol;
							begin
								if MatchText(sym.str, ['', '']) then
								begin
									syms.add(sym);
								end;
							end;

						begin
							factor;
							if MatchText(sym.str, ['*', '/', '%']) then
							begin
								syms.add(sym);
								symnext;
								factor;
							end;
						end;

					begin
						addsub;
						if MatchText(sym.str, ['==', '!=', '<', '>', '>=', '<=']) then
						begin
							syms.add(sym);
							symnext;
							addsub;
						end;
					end;

				begin
					compare;
					if MatchText(sym.str, ['!']) then
					begin
						syms.add(sym);
						symnext;
						compare;
					end;
				end;

			begin
				nott;
				if MatchText(sym.str, ['&&', '||']) then
				begin
					syms.add(sym);
					symnext;
					nott;
				end;
			end;

		begin
			andor;
			if MatchText(sym.str, ['+', '-']) then
			begin
				syms.add(sym);
				symnext;
				andor;
			end;

		end;

	begin

		addsub;
//		bsym:=sym;
		if sym.str='=' then begin
			syms.add(sym);
			symnext;
			addsub;
		end;
	end;

	function hkakko:TSymbol;
	var ret :TSymbol;
		del :TSymbol;
		sym :TSymbol;
	begin
//			sym.typ:=symKBlock;
		del.src:='][';
		del.str:=', ';
		result.addstr('[');
		while (p[0]<>#0)and(str='[') do begin
			if result.src<>'[' then result.add(del);

			result.add(statements(']'));
			if str=']' then
				sym:=symbol;
		end;
		symback;
		result.addstr(']');

//			str:=' [ '+s+'] ';
	end;

	function ckakko:Integer;
	var
		sym :TSymbol;
		dstt:TSymbol;
	begin
		inc(indent);
		varstr:='';
		sym.typ:=symCBlock;
		while (p[0]<>#0) do begin
			dstt:=statements('}');
			sym.src:=sym.src+dstt.src;
			if dstt.str<>'' then begin
				sym.str                 :=sym.str+indenttab+dstt.str;//+';';
				if come<>'' then sym.str:=sym.str+TAB+'// '+come;
				sym.str                 :=sym.str+CRLF;
			end;
			if str='}' then break;
		end;

		syms.add(sym);
		dec(indent);
	end;

	function statement:Integer;
	var
		改行まで:boolean;
		s:string;
	begin
		改行まで:=false;
		イフ:=false;
		while (p[0]<>#0) do begin
			symnext;

			if sym.typ=symComment then begin
//					if syms.count>0 then //前の要素に足す
				dsrc:=dsrc+sym.str;
				if pline=line then begin
					//psym.cmt:=sym.str+CRLF;
					continue;
				end;
				continue;
			end;
			if sym.str='[' then begin
				syms.last.add(hkakko);
				continue;
			end;
			if sym.convstr='.' then begin
				sym.str:=sym.convstr;
				syms.last.add(sym);
				sym:=symbol;
				syms.last.add(sym);
				continue;
			end;

			if sym.typ=symOperator then begin

			end;

			if str='if' then begin
				イフ:=true;

			end else if MatchStr(str,lineblock) then begin
				改行まで:=true;

			end else if MatchStr(str,varblock) then begin
				宣言ブロック:=true;

			end;

			if str=CRLF then begin
				pline:=line;
				inc(line);
//psym.cmt:=psym.cmt+CRLF;
//					dsrc:=dsrc+CRLF;
				if 改行まで then begin
					break;
				end;
				continue;
			end else if str='(' then begin
				kakko;
				continue;
			end else if str='{' then begin
				ckakko;
//					continue;
				sym:=symbol;
				//if str<>'while' then //{}while
				//	break;//{}ブロックは繋げたくない
			end else if str=breakchar then
				break;


			sym.str:=str;
			syms.add(sym);

			if not 改行まで then begin
				if str=';' then begin
					if not イフ then break;
					sym:=symbol;
					if sym.str='else' then begin
						syms.last^:=sym;
						continue;
					end;
					symback;
					break;

				end else if str=':' then begin

					if psym.typ=symKBlock then continue;    //前カッコはメンバ初期化初期化
					if 宣言ブロック then continue;//label:
					break;
				end;
			end;


		end;
	end;

begin
	s宣言ブロック:=宣言ブロック;
	syms.null.clear;
	statement;
	result.src:=syms.source;
	result.str:=trim(reconstruct);
	宣言ブロック:=s宣言ブロック;
end;


procedure TFormCBtoDEL.MConvClick(Sender: TObject);
var
	i,j        :Integer;
begin
	LOG.Clear;
//	int l=E->Perform(EM_LINEFROMCHAR,-1,0)+1;
//	int c=E->SelStart-E->Perform(EM_LINEINDEX,-1,0)+1;
//	int le=E->Perform(EM_LINEFROMCHAR, E->SelStart+E->SelLength-1, 0)+1;

	if CB.SelLength>0 then begin
		Src                  :=CB.SelText;
		src:=StringReplace(src,CR,CRLF,[rfReplaceAll]);
		line:=CB.Perform(EM_LINEFROMCHAR,System.NativeUInt(-1),0)+1;
	end else begin
		Src                  :=CB.Text;
		line:=0;
	   end;
	pline:=line;

	p                    :=pchar(Src);
	pp                   :=StrPos(p,'#end#');
	if pp<>nil then pp[0]:=#0;
	indent               :=0;
	try
		while (p[0]<>#0) do begin

			come                 :='';
			dstt                 :=statements('');
			dsrc                 :=dsrc+dstt.str;
			dsrc                 :=dsrc+CRLF;
		end;
		if varstr<>'' then begin
			dsrc:=indentcr+varstr+dsrc;
		end;
		DEL.Text:=dsrc;

	except s:='変換エラー';
	end;
	if MDvrow.Checked then
		CG.TopRow:=CG.Row;

end;





procedure TFormCBtoDEL.MCopyClick(Sender: TObject);
	procedure Copy(M:TRichEdit);
	begin
		if not M.Focused then exit;
		Clipboard.AsText:=M.SelText;
		//M.CopyToClipboard;
	end;
begin
	Copy(CB);
	Copy(DEL);
	Copy(LOG);
	TGrid(CG).CutCopy(false);

end;


procedure TFormCBtoDEL.MCutClick(Sender: TObject);
	procedure Cut(M:TRichEdit);
	begin
		if not M.Focused then exit;
		Clipboard.AsText:=M.SelText;
		M.SelText:='';
		//M.CutToClipboard;
	end;

begin
	Cut(CB);
	Cut(DEL);
	Cut(LOG);
	TGrid(CG).CutCopy(true);
end;


procedure TFormCBtoDEL.MendClick(Sender: TObject);
begin
	CB.SelText:='#end#';
end;

procedure TFormCBtoDEL.MenuItemGrid2Click(Sender: TObject);
begin
	CG.cells[1,CG.row]:=CG.cells[1,CG.row]+ split(TmenuItem(Sender).Caption,0);

end;

procedure TFormCBtoDEL.MenuItemGridClick(Sender: TObject);
begin
	CG.cells[2,CG.row]:=CG.cells[2,CG.row]+ split(TmenuItem(Sender).Caption,0);

end;

procedure TFormCBtoDEL.MFolderClick(Sender: TObject);
var
//  Dialog: IOTAKeyboardDiagnostics
s:string;
begin
//  if Supports(BorlandIDEServices, IOTAKeyboardDiagnostics, Dialog) then
//	Dialog.KeyTracing := Debugging;
//s:=GetActiveProject.FileName;
	dmessage(inidir,Application.ExeName);

end;

procedure TFormCBtoDEL.MLoadClick(Sender: TObject);
var SL:TStringDynArray;
	i:integer;
begin
	varblock:=SplitString(EditVarBlock.text,' ');
	lineblock:=SplitString(EditLineBlock.text,' ');

	if DirectoryExists(inidir) then begin
		filename:=IncludeTrailingBackslash(inidir)+'CBtoDEL'+EditSet.text;
		Ini.Free;
		Ini := TIniFile.Create(ChangeFileExt(filename,'.INI'));
	end else begin
		filename:=ChangeFileExt(Application.ExeName,'')+EditSet.text;
	end;
	txtfile:=ChangeFileExt(filename,'.txt');
	csvfile:=ChangeFileExt(filename,'.csv');
	caption:=csvfile;

	try
		 Width     := Ini.ReadInteger( 'Form', 'Width', Width );
		 Height    := Ini.ReadInteger( 'Form', 'Height', Height );
		 PanelTop.Height    := Ini.ReadInteger( 'Form', 'PanelTop.Height', PanelTop.Height );
		 Panel2.Width:=ClientWidth div 2;
		 CB.Lines.Clear;
		CB.Lines.LoadFromFile(txtfile);
	except
	end;

	try
		CG.RowCount:=1;
		CG.DrawingStyle:=gdsClassic;
		CG.DefaultRowHeight:=round(-Font.Height*1.5);
		SL.load(csvfile);
		CG.RowCount:=SL.count;
		for i:=0 to SL.hi do begin
			CG.rows[i].StrictDelimiter:=true;
			CG.rows[i].Delimiter:=',';
			CG.rows[i].QuoteChar:='"';
			CG.rows[i].DelimitedText:=sl[i];
		end;

//		gridLoadCsv(CG,csvfile,0,0);
		CG.ColCount:=SplitString(CHEAD,',').count;
		CG.Rows[0].CommaText:=CHEAD;
		CG.FixedCols:=1;
		CG.FixedRows:=1;

		gridColExpand(CG,10);

	except

	end;
		//CG.color:=clGray;
	ActiveControl:=CG;
end;

procedure TFormCBtoDEL.MSaveClick(Sender: TObject);
var SL:TStringDynArray;
	i:integer;
begin
	for i:=0 to CG.RowCount-1 do begin
		CG.rows[i].StrictDelimiter:=true;
		CG.rows[i].Delimiter:=',';
		CG.rows[i].QuoteChar:='"';
		SL.add(CG.rows[i].DelimitedText);
	end;
	SL.save(csvfile);
	CB.Lines.SaveToFile(txtfile);
end;



procedure TFormCBtoDEL.MSetClick(Sender: TObject);
begin
	TMenuItem(Sender).Checked:=not TMenuItem(Sender).Checked;
	CG.FixedCols:=(not MFixed.Checked).ToInteger;
end;

procedure TFormCBtoDEL.MRowDelClick(Sender: TObject);
begin
	gridRowDelete(CG,CG.Row,1);

end;

procedure TFormCBtoDEL.MRowDupClick(Sender: TObject);
begin
	gridRowInsert(CG,CG.Row,1);
	CG.Rows[CG.Row]:=CG.Rows[CG.Row+1];
end;

procedure TFormCBtoDEL.MPasteClick(Sender: TObject);
	procedure Paste(M:TRichEdit);
	begin
		if not M.Focused then exit;
		M.PasteFromClipboard;
	end;
begin
	Paste(CB);
	Paste(DEL);
	Paste(LOG);
	TGrid(CG).Paste;
end;

{ TSymbols }

function TSymbols.add(s:TSymbol):Integer;
begin
	SetLength(self.items,Length(self.items)+1);
	self[Length(self.items)-1]:=s;
	result              :=Length(self.items);
end;

function TSymbols.clear:Integer;
begin
	SetLength(self.items,0);
end;

function TSymbols.count:Integer;
begin
	result:=Length(self.items);
end;
function TSymbols.hi:Integer;
begin
	result:=High(self.items);
end;

function TSymbols.last: PSymbol;
begin
	if count=0 then exit(@null);
	result:=@self.items[count-1];
end;


function TSymbols.getstring(Index:Integer):string;
begin
	if index>High(self.items) then exit('');
	if index<0 then exit('');
	result:=self.items[index].str;
end;

procedure TSymbols.putstring(Index:Integer;const s:string);
begin
	if index>High(self.items) then exit;
	if index<0 then exit;
	self.items[index].str:=s;
end;

function TSymbols.get(Index:Integer):TSymbol;
begin
	if index>High(self.items) then exit(null);
	if index<0 then exit(null);
	result:=self.items[index];
end;

procedure TSymbols.put(Index:Integer;const s:TSymbol);
begin
	if index>High(self.items) then exit;
	if index<0 then exit;
	self.items[index]:=s;
end;


function TSymbols.source: string;
var sym:TSymbol;
	s:string;
begin
	for sym in self.items do begin
		s:=sym.src;
		if sym.typ=symBlock        then s:=s+';';
		if sym.typ=symKBlock       then s:=' ( '+s+' ) ';
		if sym.typ=symCBlock       then s:=' { '+s+' } ';

		if result='' then result:=s else result:=result+' '+s;
	end;
end;

function TSymbols.structure: string;
var sym:TSymbol;
begin
	for sym in self.items do begin
		if result='' then result:=sym.typestr else result:=result+' '+sym.typestr;
	end;
end;

function TSymbols.structureis(position:integer;arg: array of TSymbolType):boolean;
var
	i:Integer;
begin
	if high(arg)<>high(self.items) then exit(false);
	result:=true;
	for i :=0 to high(arg) do begin
		if position+i>=count then exit(false);
		try
			if self[position+i].typ<>arg[i] then exit(false);
		except exit(false);
		end;
	end;
end;

function TSymbols.structureisstr(position:integer;arg: TStringDynArray):integer;
var
	i,j,si,di:Integer;
	sym:TSymbol;
	typestr:string;
	s:string;
	wild:boolean;
	match:boolean;

	function regmatch(t,s:string):boolean;
	var
	  regex: TRegEx;
	  match: TMatch;
		g:TGroup;
		i:integer;
	begin
		regex := TRegEx.Create(s);
//		regmatchstr:=regex.Matchs(t);
		match := regex.Match(t);
		result:=match.Success;
		for i:=1 to match.Groups.Count-1 do begin
			g:=match.Groups.Item[i];
			regmatchstr.add(g.Value);
			regmatchstr[0]:=inttostr(regmatchstr.count);

		end;

//		result:=false;
//		while match.Success do begin
//			result:=true;
//			match := match.NextMatch();
//		end;
	end;

	function regis(t,s:string):boolean;
	var
	  regex: TRegEx;
	begin
		regex := TRegEx.Create(s);
		result:=regex.Match(t).Success;
	end;


	function compare(si,di:integer):boolean;
	begin
		result:=true;
			if di>hi then exit(false);
			if si>arg.hi then exit(false);
			sym:=self[di];
			typestr:=sym.typestr;

			if MatchesMask(arg[si],'/*/') then begin
				if regmatch(sym.src,dtrimstring(arg[si],'/')) then exit(true);
				exit(false);
			end;

			if arg[si]='左' then begin
				if sym.typestr<>'文' then
					exit(false);
				exit(true);
			end else
			if arg[si]='右' then begin
				if typestr<>'数' then
					if typestr<>'文' then
						if typestr<>'文字列' then
							if typestr<>'(*)' then exit(false);
				exit(true);
			end;
//			if (sym.typ=symKBlock) then begin
//				if arg[si]='(*)' then continue;
//				if MatchesMask(arg[si],'(*)') then begin
//					s:=dtrimstring(arg[si],' ()');
//					if regmatch(sym.src,s) then continue;
//				end;
//			end;

			if (sym.typ=symDelimiter)and(sym.str=arg[si]) then exit(true);

			if (sym.typ=symOperator)and(sym.str=arg[si]) then exit(true);
			if (sym.typ=symQualifier)and MatchesMask(sym.str,arg[si]) then exit(true);
			if (sym.typ=symReserved)and MatchesMask(sym.str,arg[si]) then exit(true);
			if arg[si]<>typestr then exit(false);

	end;


begin
	regmatchstr.count:=1;
//	if high(arg)>high(self.items) then exit(false);
	si:=0;
	di:=0;
	result:=0;
	wild:=false;
	match:=false;
	for i :=0 to self.hi do begin
		try
			di:=position+i;
			if si>high(arg) then begin
				break;
			end;
			if arg[si]='＊' then begin
				wild:=true;
				inc(si);
			end;

			if compare(si,di) then begin
				match:=true;
				if wild then wild:=false;
			end else begin
				if not wild then exit(0);
			end;
			if not wild then inc(si);
//			if si>high(arg) then break;

		except
			dmessage(arg[i],self[position+i].str);
			exit(0);
		end;
	end;
	if match then
		result:=di-position;
end;

function ISALPHA(c:CHAR):boolean;
begin
	result:=(('A'<=c)and(c<='Z'))or(('a'<=c)and(c<='z'));
end;

function ISNUMBER(c:CHAR):boolean;
begin
	result:=(strscan('0123456789.',c)<>nil)and(c<>#0);
end;

function ISDELIMITER(c:CHAR):boolean;
begin
	result:=(strscan('''"(),;:[]{}'#13#10,c)<>nil)and(c<>#0);
end;

function ISOPERATOR(c:CHAR):boolean;
begin
	result:=(strscan('.*^%/-+|&=<>\!',c)<>nil)and(c<>#0);
end;

function ISSPACER(c:CHAR):boolean;
begin
	result:=(strscan(' '#9,c)<>nil)and(c<>#0);
end;

function symget(var pos:pchar;str:pchar;strdeli:CHAR):TSymbolType;
var
	i,n    :Integer;
	prechr :CHAR;
	typ:TSymbolType;
label getsymerror;
	function addchr(c:CHAR):boolean;
	begin
		if (n>=SYMMAXLEN) then exit(true);
		str[n]:=c;
		inc(n);
		result:=false;
	end;
	function addchrinc:boolean;
	begin
		if (n>=SYMMAXLEN) then exit(true);
		str[n]:=pos[0];
		inc(n);
		inc(pos);
		result:=false;
	end;
	function addchrtype(t:TSymbolType):boolean;
	begin
		if (n>=SYMMAXLEN) then exit(true);
		str[n]:=pos[0];
		inc(n);
		inc(pos);
		symtyp:=t;
		result :=false;
	end;
	function isadd(s:PChar;t:TSymbolType):boolean;
	begin
		result:=(strlcomp(pos,s,Length(s))=0);
		if not result then exit;
		symtyp:=t;
		StrLCopy(str,s,Length(s));
		inc(n,Length(s));
		inc(pos,Length(s));
	end;
	function iscat(s:PChar;t:TSymbolType):boolean;
	begin
		result:=(strlcomp(pos,s,Length(s))=0);
		if not result then exit;
		symtyp:=t;
		str[n]:=#0;
		StrLCat(str,s,Length(str)+Length(s));
		inc(n,Length(s));
		inc(pos,Length(s));
	end;


begin
	n                          :=0;
	symtyp                    :=symVoid;
	if (pos[0]=#0) then symtyp:=symDelimiter;

	while ISSPACER(pos[0]) do inc(pos);

	while (pos[0]<>#0) do begin
		if ISNUMBER(pos[0]) then begin
			while ISNUMBER(pos[0]) do begin
				if addchrinc then break;
				symtyp:=symNumber;
			end
		end else if isadd('//',symComment) then begin
			while (pos[0]<>#0) do begin
				if iscat(CRLF,symComment) then break;
				addchrinc;
			end
		end else if isadd('/*',symComment) then begin
			while (pos[0]<>#0) do begin
				if iscat('*/',symComment) then break;
				addchrinc;
			end

		end else if isadd('<<=',symOperator) then begin
		end else if isadd('>>=',symOperator) then begin
		end else if isadd('<<',symOperator) then begin
		end else if isadd('>>',symOperator) then begin
		end else if isadd('++',symOperator) then begin
		end else if isadd('--',symOperator) then begin
		end else if isadd('==',symOperator) then begin
		end else if isadd('!=',symOperator) then begin
		end else if isadd('<=',symOperator) then begin
		end else if isadd('>=',symOperator) then begin
		end else if isadd('+=',symOperator) then begin
		end else if isadd('-=',symOperator) then begin
		end else if isadd('/=',symOperator) then begin
		end else if isadd('*=',symOperator) then begin
		end else if isadd('%=',symOperator) then begin
		end else if isadd('&=',symOperator) then begin
		end else if isadd('|=',symOperator) then begin
		end else if isadd('^=',symOperator) then begin
		end else if isadd('~=',symOperator) then begin
		end else if isadd('&&',symOperator) then begin
		end else if isadd('||',symOperator) then begin
		end else if isadd('::',symOperator) then begin
		end else if isadd('->',symOperator) then begin
		end else if ISOPERATOR(pos[0]) then begin

			if addchrinc then break;
			symtyp:=symOperator;

		end else if (pos[0]='''')or(pos[0]='"')or((pos[0]='L')and ((pos[1]='"')or(pos[1]=''''))) then begin
				if (pos[0]='L') then inc(pos);
				if (pos[0]='"') then strdeli :='"' else
				if (pos[0]='''') then strdeli:='''' ;
				inc(pos);
				addchr('''');
				while (pos[0]<>#0) do begin
					if (pos[0]=strdeli) then break;
					if (pos[0]='\')and(pos[1]=strdeli) then begin
						inc(n);
						if (n>=SYMMAXLEN) then break;
						str[n]:=strdeli;
						inc(pos,2);
						continue;
					end;
					if (pos[0]='\')and(pos[1]=CR) then begin
						inc(pos);
						inc(pos);
						inc(pos);
					end;
					if (pos[0]=CR) then goto getsymerror;
					if (n>=SYMMAXLEN) then break;
					str[n]:=pos[0];
					inc(n);
					inc(pos);
				end;
				if (pos[0]=strdeli) then begin
					addchr('''');
					inc(pos);
					symtyp:=symString;
				end
				else symtyp:=symError;

		end else if ISDELIMITER(pos[0]) then begin

			symtyp:=symDelimiter;
			if (StrPos(pos,#13#10)=pos) then begin
				if ((n+1)>=SYMMAXLEN) then break;
				strmove(str,pos,2);
				n  :=n+2;
				pos:=pos+2;
			end else begin
				if (n>=SYMMAXLEN) then break;
				str[n]:=pos[0];
				inc(n);
				inc(pos);
			end;
		end else begin
			while pos[0]<>#0 do begin
				if ISOPERATOR(pos[0]) then break;
				if ISDELIMITER(pos[0]) then break;
				if ISSPACER(pos[0]) then break;
				if (n>=SYMMAXLEN) then break;
				str[n]:=pos[0];
				inc(n);
				if (n>=255) then break;
				inc(pos);
			end;
			symtyp:=symReserved;
		end;

		if (n>=SYMMAXLEN) then break;
		if (symtyp<>symVoid) then break;
		prechr:=pos[0];
		inc(pos);
	end;
	//    while ISSPACER(pos[0]) do inc(pos);

	str[n]:=#0;
	result:=symtyp;
	exit;
getsymerror:
	str[0]:=#0;
	result:=symVoid;
end;


{ TSymbol }

function TSymbol.convstr: string;
begin
	if str='!=' then exit('<>');
	if str='->' then exit('.');
	if str='==' then exit('=');
	if str='='  then exit(':=');
	if str='||' then exit('or');
	if str='|'  then exit('or');
	if str='&&' then exit('and');
	if str='&'  then exit('and');
	if str='!'  then exit('not');
	exit(str);
end;


function TSymbol.add(c: TSymbol): string;
begin
	str:=str+c.str;
	src:=src+c.src;
end;

function TSymbol.addstr(s: string): string;
begin
	str:=str+s;
	src:=src+s;

end;

procedure TSymbol.clear;
begin
	typ:=symError;
	str:='';
	src:='';
end;

function TSymbol.convblock: string;
begin
//	if typ=symBlock        then exit(str+';');
	if typ=symKBlock       then exit(' ( '+str+') ');
	if typ=symCBlock       then exit(' begin '+str+' end ');
	exit(str);
end;

function TSymbol.typestr: string;
begin
	if typ=symType         then exit('Type');
	if typ=symVoid         then exit('Void');
	if typ=symNumber       then exit('数');
	if typ=symChar         then exit('文字');
	if typ=symInt          then exit('Int');
	if typ=symDouble       then exit('Double');
	if typ=symString       then exit('文字列');
	if typ=symStruct       then exit('Struct');
	if typ=symSemicolon    then exit(';');
	if typ=symColon        then exit(':');

	if typ=symAnd          then exit('&&' );
	if typ=symOr           then exit('||' );
	if typ=symPointer      then exit('*' );
	if typ=symRef          then exit('&' );

	if typ=symBlock        then exit('*;');
	if typ=symKBlock       then exit('(*)');
	if typ=symCBlock       then exit('{*}' );
	if typ=symOperator     then exit('演算子');
	if typ=symCommand      then exit('命令' );
	if typ=symLabel        then exit('ラベル'   );
	if typ=symDelimiter    then exit('区切');
	if typ=symEnd          then exit('End'      );
	if typ=symJump         then exit('Jump'     );
	if typ=symQualifier    then exit('修飾子');
	if typ=symReserved     then exit('文' );
	if typ=symFunction     then exit('関数' );
	if typ=symVariable     then exit('変数' );
	if typ=symArray        then exit('配列'    );
end;

{ TStringDynArrayHelper }

function TStringDynArrayHelper.add(s: string): Integer;
begin
	SetLength(self,Length(self)+1);
	self[Length(self)-1]:=s;
	result              :=Length(self);

end;

function TStringDynArrayHelper.getcount: Integer;
begin
	result:=Length(self);
end;

procedure TStringDynArrayHelper.setcount(const i:integer);
begin
	SetLength(self,i);
end;

function TStringDynArrayHelper.hi: Integer;
begin
	result:=High(self);

end;

function TStringDynArrayHelper.item(i: Integer): String;
begin
	if i<0 then exit;
	if i>High(self) then exit;
	result:=self[i];
end;

function TStringDynArrayHelper.save(f: string): boolean;
begin
	with stringselfcreate do
		try
			SavetoFile(f);
		except
			Free;
		end;
end;


function TStringDynArrayHelper.load(f: string): boolean;
begin
	with TStringList.Create do
		try
			LoadFromFile(f);
			self:=TStringDynArray(ToStringArray);
		except
			Free;
		end;
end;

function TStringDynArrayHelper.stringselfcreate:TStringSelf;
var s:string;
begin
	result:=TStringSelf.Create;
	for s in self do result.Add(s);
end;


constructor TGrid.CreateEX(Origin :TStringGrid);
var
  MS :TMemoryStream;
begin
  Create(Origin.Owner);
  Self.Parent :=Origin.Parent;
  Self.Options :=Origin.Options;
  Self.OnSetEditText :=Origin.OnSetEditText;

  MS :=TMemoryStream.Create;
   try
	 MS.WriteComponent(Origin);
	 Origin.Free;
	 MS.Position :=0;
	 MS.ReadComponent(Self);
   finally
	MS.Free;
   end;
end;

procedure TGrid.WMChar(var Msg: TWMChar);
begin
//	if (EnableEdit) and (AnsiChar(Msg.CharCode) in [^H, #32..#255]) then begin
	if ((CharInSet(Char(Msg.CharCode), [^H]) or (Char(Msg.CharCode) >= #32))) then begin
		Options:=Options+[goEditing];
		EditorMode:=true;

//		ShowObject(Word(Msg.CharCode));
//		if Edit.Visible then
//			PostMessage(Edit.Handle, WM_CHAR, Word(Msg.CharCode), 0);
//		if Combo.Visible then
//			PostMessage(Combo.Handle, WM_CHAR, Word(Msg.CharCode), 0);

	end else
		inherited;
end;







procedure TGrid.CutCopy(modecut:boolean);
var
	i,j:integer;
	xs,ys,xw,yw:integer;
	Txt:TStringList;
	s,ss:String;
	r:TGridRect;

	function d_dquotedstr(const s,d:string):string;
	var
		c:Char;
		b:boolean;
	begin
		result:=s;
		b:=false;
		if d='' then b:=true;
		for c in s do if pos(c,d)>0 then b:=true;

		if not b then exit;
		result:='"'+s+'"';
	end;

begin
	if not Focused then exit;
	ys:=Selection.Top;
	xs:=Selection.Left;
	yw:=Selection.Bottom-ys;
	xw:=Selection.Right-xs;

	Txt:=TStringList.Create;
	for i:=0 to yw do begin
		s:='';
		for j:=0 to xw do begin
			if j>0 then s:=s+#9;
				ss:=StringReplace(Cells[xs+j,ys+i],#9,'',[rfReplaceAll]);//タブは削除
				//if Pos(ss,CRLF)>0 then
				ss:=d_dquotedstr(ss,CRLF);
				s:=s+ss;
				if modecut then Cells[xs+j,ys+i]:='';
		end;
		Txt.Add(s);
	end;
	s:=Txt.Text;
	s[Length(s)-1]:=#0;
	Clipboard.AsText:=s;
	Txt.Free;
end;

function TGrid.Paste:TGridRect;
var
	i,j,si,colcnt:integer;
	s:String;
	Txt:TStringList;
	ltxt:string;
	xs,ys,xw,yw,cnt:integer;
	cols:TStringDynArray;

begin
	if not Focused then exit;

	Txt:=TStringList.Create;
	s:=StringReplace(Clipboard.AsText,CRLF,CR,[rfReplaceAll]);
	for ltxt in SplitString(s,CR) do
		Txt.add(ltxt);


	ys:=Selection.Top;
	xs:=Selection.Left;
	yw:=txt.Count-1;
	xw:=1;
	for i:=0 to yw do begin
		s:=txt[i];
		colcnt:=SplitString(s,#9).count;
		if xw<colcnt then xw:=colcnt;
	end;
	dec(xw);


	si:=1;
	for i:=0 to yw do begin
		for j:=0 to xw do begin
			cols:=SplitString(txt[i],#9);
			s:=cols.item(j);
			Cells[xs+j,ys+i]:=s;
		end;
	end;
	Txt.Free;
	result:=GridRect(xs,ys,xs+xw,ys+yw);
end;

procedure TGrid.KeyDown(var Key: Word; Shift: TShiftState);
var w:word;
begin
		if ssCtrl in Shift then begin
		if key=17 then exit;
		case Key of
	//		WORD('A'):;
			WORD('X'):CutCopy(true);
			WORD('C'):CutCopy(false);
			WORD('V'):Paste;
		end;
		end;

	inherited;
end;

procedure TFormCBtoDEL.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if ssCtrl in Shift then begin
	if key=17 then exit;
	case Key of
//		WORD('A'):;
		WORD('X'):MCutClick(Sender);
		WORD('C'):MCopyClick(Sender);
		WORD('V'):MPasteClick(Sender);
	end;
	key:=0;
	end;
end;

procedure TGrid.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	ACol,ARow:Longint;
begin
	MouseToCell(X,Y,ACol,ARow);

	Options:=Options-[goEditing]+[goRangeSelect];

	if(Button=mbLeft)then begin
		if(FixedRows>0) and (ARow=0) and (ACol>0) and not Sizing(X,Y) then begin
		end	 else if (FixedCols>0) and (ACol=0) and (ARow>0) and not Sizing(X,Y) then begin
		end	else if((Col=ACol) and (Row=ARow))then begin
			Options:=Options+[goEditing]-[goRangeSelect];
			EditorMode:=true;
		end else begin
			EditorMode:=false;
		end;
	end;

	inherited;
end;

function GetNumScrollLines: Integer;
begin
  SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, @Result, 0);
end;

function TGrid.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
var
i:integer;
begin
	for I := 1 to GetNumScrollLines do SendMessage(Handle, WM_VSCROLL, SB_LINEDOWN, 0);
	Result := True;
end;

function TGrid.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
var
i:integer;
begin
	for I := 1 to GetNumScrollLines do SendMessage(Handle, WM_VSCROLL, SB_LINEUP, 0);
	Result := True;
end;



initialization
   Ini := TIniFile.Create( ChangeFileExt( Application.ExeName, '.INI' ) );
finalization
	Ini.Free;
end.








				//命令
//				if sis('*.Contains｜(*)') then begin   //集合
//					s:=' ('+incgetsrc(1)+' in '+StringReplace(incgetsrc(0),'.Contains','',[])+') ';
//
//				end else

//				if sis('if｜(*)') then begin   //if
//					s:=incgetsrc(0)+' '+incgetsrc(1)+' then ';
//				end else
//				if sis('do｜{*}｜while｜(*)') then begin   //do while falseで終了   repeat until trueで終了
//					incgetsrc(0);
//					incgetsrc(2);
//					s:='repeat'+CRLF+incgetsrc(1)+' until not ( '+incgetsrc(3)+' ) ';
//				end else
//				if sis('while｜(*)') then begin   //while
//					s:=incgetsrc(0)+' '+incgetsrc(1)+' do ';
//				end else
//				if sis('return') then begin   //return 式;  exit(式)　
//					incget(0);
//					s:='Exit( '+inccat+' )'
//				end else

//				if sis('for｜(*)') then begin   //if
//					incgetsrc(0);
//					s:=incgetsrc(1);
//					param:=SplitString(s,';');
//					s:=makefor;
//
//					if (s='') then begin
//						if sis('for｜(*)｜{*}') then begin
//							ss:=incgetsrc(2);
//							s:='{for} '+param[0]+';'+CRLF;
//							s:=s+'{for}while'+' '+param[1]+' do begin'+CRLF
//								+indenttab+TAB+param[2]+';'+CRLF
//								+indenttab+ss
//								+indenttab+'end;'+CRLF;
//						end else begin
//							s:=param[0]+';'+indentcr;
//							s:=s+'{for}while'+' '+param[1]+' do begin'+CRLF
//								+indenttab+TAB+param[2]+';'+CRLF
//								+indenttab+TAB+inccat+CRLF
//								+indenttab+'end;'+CRLF;
//
//						end;
//					end;
//
//				end else

//				if sis('enum｜文｜{*}') then begin
//					s:=StringReplace(incgetsrc(2),':=','=',[rfReplaceAll]);
//					s:=StringReplace(s,' , ',','+CRLF+indenttab+tab,[rfReplaceAll]);
//					s:=incgetsrc(1)+' = ( '+CRLF+s+');'+CRLF;
//					incgetsrc(0);
//
//				end else

//				if sis('union｜文｜{*}') then begin
//					incgetsrc(0);
//					s:='case Integer of '+CRLF+incgetsrc(1)+CRLF+incgetsrc(2)+CRLF;
//					s:=s+indenttab+'end;';
//
//				end else
//				if sis('union｜{*}') then begin
//					incgetsrc(0);
//					s:='case Integer of '+CRLF+incgetsrc(1)+CRLF;
//					s:=s+indenttab+'end;'+CRLF;
//
//				end else
//				if sis('struct｜文｜{*}') then begin
//					incgetsrc(0);
//					s:='record'+CRLF+incgetsrc(1)+CRLF+incgetsrc(2)+CRLF;
//					s:=s+indenttab+'end;'+CRLF;
//
//				end else
//				if sis('struct｜{*}') then begin
//					incgetsrc(0);
//					s:='record'+CRLF+incgetsrc(1)+CRLF;
//					s:=s+indenttab+'end;';
//
//				end else
//
//				if sis('class｜文｜{*}') then begin
//					s:=incgetsrc(1)+' = '+incgetsrc(0)+CRLF+incgetsrc(2)+CRLF;
//					s:=s+indenttab+'end;'+CRLF;
//
//				end else
//				if sis('class｜文｜文｜{*}') then begin
//					s:=incgetsrc(2)+' = '+incgetsrc(0)+CRLF+incgetsrc(3);
//					s:=s+indenttab+'end;'+CRLF;
//					incgetsrc(1);
//				end else


//				if sis('#define｜文｜(*)') then begin//#define 名前() は関数へ　一列すべて読む処理をいれる
//					incgetsrc(0);
//					s:='function '+incgetsrc(1)+' ( '+incgetsrc(2)+':variant ) : variant; begin ';
//					ss:=inccat;
//					s:=s+'exit ( '+ss+' ); end ;';
//
//				end else
//				if sis('#define｜文') then begin//#define 名前 値
//					incgetsrc(0);
//					conststr:=incgetsrc(1);
//					s:=conststr+' = '+inccat;
//
//				end else

				//#define a 1*2  計算
				//#define acb(d) 123*d  ()ありは式は関数？

				//6
//				if sis('文｜&｜文｜::｜文｜(*)') then begin //関数 参照
//					s:='function '+incget(2)+'.'+incget(4)+' '+incget(5)+' : '+incget(0);
//					come:=incget(1);
//					incget(6);
//					stype:=symFunction;
//
//				end else
//				if sis('文｜*｜文｜::｜文｜(*)') then begin //関数 ポインタ
//					s:='function '+incget(2)+'.'+incget(4)+' '+incget(5)+' : '+incget(0);
//					come:=incget(1);
//					stype:=symFunction;
//					incget(6);
//
//				end else
//				//4
//				if sis('文｜&｜文｜(*)') then begin //関数 参照
//					s:='function '+incget(2)+' '+incget(3)+' : '+incget(0);
//					come:=incget(1);
//					stype:=symFunction;
//
//				end else
//				if sis('文｜*｜文｜(*)') then begin //関数 ポインタ
//					s:='function '+incget(2)+' '+incget(3)+' : '+incget(0);
//					come:=incget(1);
//					stype:=symFunction;
//
//				end else
//				if sis('修飾子｜文｜&｜文') then begin //宣言 const 参照　%0 %3 : %1
//					s:=incget(0)+' '+incgetval(3)+' : '+incget(1);
//					come:=incget(2);
//				end else
//				if sis('修飾子｜文｜*｜文') then begin //宣言 const ポインタ
//					s:=incget(0)+' '+incgetval(3)+' : '+incget(1);
//					come:=incget(2);
//
//				end else
//				if sis('修飾子｜文｜文') then begin     //宣言 const
//					s:=incget(0)+' '+incgetval(2)+' : '+incget(1);
//
//				end else
				//3
//				if sis('文｜&｜文') then begin //宣言 参照
//					s:=incgetval(2)+' : '+incget(0);
//					come:=incget(1);
//
//				end else
//				if sis('文｜*｜文') then begin //宣言 ポインタ
//					s:=incgetval(2)+' : '+incget(0);
//					come:=incget(1);
//
//				end else
//				//2
//				if sis('文｜:') then begin  //スコープ
//					s:=incgetsrc(0);
//					incget(1);
//					stype:=symLabel;
//
//				end else
//				if sis('左｜文') then begin  //宣言
//					s:=incgetval(1)+' : '+incget(0);
//
//				end else
//				if sis('(*)｜文') then begin //キャスト
//					s:=Split(incgetsrc(0),0)+'( '+incget(1)+' )'
//
//				end else
//				if sis('(*)｜(*)') then begin //キャスト
//					s:=incget(2)+' : '+incget(0);
//				end else



//				if valname<>'' then begin
//					varstr:=varstr+indentstr(s)+';'+CRLF;
//					if syms[pos].str='=' then //宣言の次が代入
//						s:=split(s,0,':')+'{:'+split(s,1,':')+'}';
//				end;

//			function makefor:string;
//			var
//				param1:TStringDynArray;
//				param2:TStringDynArray;
//				param3:TStringDynArray;
//				s,vname:string;
//			begin
//				param1:=SplitString(trim(param[0]),' ');
//				param2:=SplitString(trim(param[1]),' ');
//				param3:=SplitString(trim(param[2]),' ');
//
//				if (Length(param1)>=3)and(Length(param2)=3)and(Length(param3)=2)then begin
//
//					if param1[2]=':=' then vname:=param1[1];
//					if param1[1]=':=' then vname:=param1[0];
//					if vname='' then exit;            //制御変数なし
//					if vname<>param2[0] then exit;    //制御異なる
//					if vname<>param3[0] then exit;    //制御異なる
//
//					if (param2[1]='<') and (param3[1]='++') then s:=' to '     +param2[2]+'-1 do ';
//					if (param2[1]='>') and (param3[1]='--') then s:=' downto ' +param2[2]+'+1 do ';
//					if (param2[1]='<=') and (param3[1]='++') then s:=' to '    +param2[2]+' do ';
//					if (param2[1]='>=') and (param3[1]='--') then s:=' downto '+param2[2]+' do ';
//
//					result:='for '+param[0]+s;
//				end;
//			end;
////	CG.Options:=CG.Options-[goEditing];
////	p:=ClientToScreen(Point(x, y));
//////	CG.Dra
////	SendMessage(CG.Handle, WM_LBUTTONDOWN, 0, MAKELPARAM(x,y));
//
//	CG.MouseToCell(X,Y,ACol, ARow);
//	if Point(ACol,ARow)<>Point(PCol,PRow) then exit;
////	CG.Options:=CG.Options+[goEditing];
////	CG.EditorMode:=true;

//	CG.MouseToCell(X,Y,ACol, ARow);
//	if Point(PCol,PRow)=Point(ACol,ARow) then begin
//		CG.Options:=CG.Options+[goEditing];
//		CG.EditorMode:=true;
//	end;
//	if Point(CG.Col,CG.Row)=Point(ACol,ARow) then begin
//		PCol:=ACol;
//		PRow:=ARow;
//	end;

//						for c:= 0 to para.hi do begin
//							ns:=inttostr(c+1);
//							vrv:=StringReplace(vrv,'%'+ns+'%',get(c),[rfReplaceAll]);
//							vrv:=StringReplace(vrv,'%s'+ns+'%',getstr(c),[rfReplaceAll]);
//							vrv:=StringReplace(vrv,'%o'+ns+'%',getsrc(c),[rfReplaceAll]);
//
////							rep:=dstringregexreplace(rep,'%'+ns+'%',rep)
//							regmtc := TRegEx.Matches(rep,'%'+ns+'(.)([1-9]+)%');
//							for regmt in regmtc do
//								if regmt.Groups.Count=3 then begin
//									subc:=dval(regmt.Groups[2].value);
//									subd:=regmt.Groups[1].value;
//									subs:=regmt.Groups[0].value;
//									subr:=trim(split(syms[c].str,subc-1,subd));
//									rep:=StringReplace(rep,subs,subr,[rfReplaceAll]);
//								end;
//
//
//							rep:=StringReplace(rep,'%'+ns+'%',get(c),[rfReplaceAll]);
//							rep:=StringReplace(rep,'%s'+ns+'%',getstr(c),[rfReplaceAll]);
//							rep:=StringReplace(rep,'%o'+ns+'%',getsrc(c),[rfReplaceAll]);
////							rep:=StringReplace(rep,'%e'+ns+'%',getenum(c),[rfReplaceAll]);
//							rep2:=StringReplace(rep,'%c'+ns+'%',cat(c),[rfReplaceAll]);
//							if rep<>rep2 then begin
//								pos:=syms.count; //
//								rep:=rep2;
//								break;
//							end;
//							rep:=StringReplace(rep,'%CR%',CRLF,[rfReplaceAll]);
//							rep:=StringReplace(rep,'%E%',indenttab+'end;',[rfReplaceAll]);
//							rep:=StringReplace(rep,'%t%',TAB,[rfReplaceAll]);
//							rep:=StringReplace(rep,'%i%',indenttab,[rfReplaceAll]);
//							rep:=StringReplace(rep,'%i+%',indenttabplus,[rfReplaceAll]);
//							inc(pos);
//						end;

//						for c:= 0 to regmatchstr.hi do begin
//							s:=regmatchstr.item(c);
//							rep:=StringReplace(rep,'%x'+inttostr(c)+'%',s,[rfReplaceAll]);
//						end;


//			function getenum(i:integer):string;   //

//			begin
//				inc(i,posstart);
//				result:=StringReplace(syms[i].str,':=','=',[rfReplaceAll]);
//				result:=StringReplace(result,' , ',','+CRLF+indenttab+tab,[rfReplaceAll]);
//			end;
//


