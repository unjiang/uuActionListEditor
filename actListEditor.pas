{ *************************************************************************** }
{ 2019 unjiang 修改                                                                            }
{ EControl Form Designer Pro                                                  }
{                                                                             }
{ Copyright (c) 2004 - 2009 EControl Ltd.                                     }
{     www.econtrol.ru                                                         }
{     support@econtrol.ru                                                     }
{                                                                             }
{ *************************************************************************** }

unit actListEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Menus,
  Dialogs, actnList, ComCtrls, ImgList, StdCtrls, ExtCtrls, ToolWin,
  actListEditorDsnConst, ActionEditors, VCLEditors, DesignEditors, DesignWindows,
  DesignIntf, System.Actions;

const
  AM_DeferUpdate = WM_USER + 100;  // avoids break-before-make listview ugliness

type
  TActionListEditor = class(TDesignWindow)
    ToolBar1: TToolBar;
    Panel1: TPanel;
    ActListView: TListView;
    Label1: TLabel;
    PnlResources: TPanel;
    Label2: TLabel;
    TV: TTreeView;
    Splitter1: TSplitter;
    PnlCategories: TPanel;
    Label3: TLabel;
    CatList: TListBox;
    Splitter2: TSplitter;
    ActionList1: TActionList;
    ImageList1: TImageList;
    actNew: TAction;
    actDelete: TAction;
    actMoveUp: TAction;
    actMoveDown: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    actCut: TAction;
    actCopy: TAction;
    actPaste: TAction;
    actSelectAll: TAction;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    PopupMenu1: TPopupMenu;
    actCut1: TMenuItem;
    actCopy1: TMenuItem;
    actPaste1: TMenuItem;
    N1: TMenuItem;
    actSelectAll1: TMenuItem;
    N2: TMenuItem;
    actDelete1: TMenuItem;
    actCopyStandard: TAction;
    NewStandardAction1: TMenuItem;
    ToolButton11: TToolButton;
    PnlRespository: TPanel;
    Splitter3: TSplitter;
    Label4: TLabel;
    TVRes: TTreeView;
    Copy1: TMenuItem;
    actShowToolbar: TAction;
    oolbar1: TMenuItem;
    ActionShowCaptions: TAction;
    ShowCaptions1: TMenuItem;
    actDelRepository: TAction;
    actCopyRepository: TAction;
    PopupMenu2: TPopupMenu;
    Delete1: TMenuItem;
    act1: TMenuItem;
    N3: TMenuItem;
    actExpandAll: TAction;
    actCollapseAll: TAction;
    N4: TMenuItem;
    ExpandAll1: TMenuItem;
    CollapseAll1: TMenuItem;
    PopupMenu3: TPopupMenu;
    NewStandardAction2: TMenuItem;
    N5: TMenuItem;
    ExpandAll2: TMenuItem;
    CollapseAll2: TMenuItem;
    Actionfavor: TAction;
    ToolButtonfavor: TToolButton;
    ToolButton12: TToolButton;
    ToolButtonactShowCaptions: TToolButton;
    ActionInput: TAction;
    ToolButtonInput: TToolButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CatListClick(Sender: TObject);
    procedure ActListViewChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure actDeleteUpdate(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure ActListViewDblClick(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actMoveUpUpdate(Sender: TObject);
    procedure actMoveDownUpdate(Sender: TObject);
    procedure actMoveUpExecute(Sender: TObject);
    procedure actMoveDownExecute(Sender: TObject);
    procedure ActListViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actPasteUpdate(Sender: TObject);
    procedure actCutExecute(Sender: TObject);
    procedure actSelectAllUpdate(Sender: TObject);
    procedure actCopyExecute(Sender: TObject);
    procedure actSelectAllExecute(Sender: TObject);
    procedure actPasteExecute(Sender: TObject);
    procedure ActListViewEnter(Sender: TObject);
    procedure ActListViewDragOver(Sender, Source: TObject; X, Y: Integer; State:
      TDragState; var Accept: Boolean);
    procedure ActListViewDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure CatListDragOver(Sender, Source: TObject; X, Y: Integer; State:
      TDragState; var Accept: Boolean);
    procedure CatListDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure actCopyStandardUpdate(Sender: TObject);
    procedure actCopyStandardExecute(Sender: TObject);
    procedure TVStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure Label1Click(Sender: TObject);
    procedure TVResDragOver(Sender, Source: TObject; X, Y: Integer; State:
      TDragState; var Accept: Boolean);
    procedure TVResDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TVResChange(Sender: TObject; Node: TTreeNode);
    procedure TVResEnter(Sender: TObject);
    procedure TVResExit(Sender: TObject);
    procedure TVResKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TVResCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure actShowToolbarUpdate(Sender: TObject);
    procedure actShowToolbarExecute(Sender: TObject);
    procedure ActionShowCaptionsUpdate(Sender: TObject);
    procedure ActionShowCaptionsExecute(Sender: TObject);
    procedure TVDblClick(Sender: TObject);
    procedure actDelRepositoryUpdate(Sender: TObject);
    procedure actExpandAllUpdate(Sender: TObject);
    procedure actExpandAllExecute(Sender: TObject);
    procedure actCollapseAllExecute(Sender: TObject);
    procedure actDelRepositoryExecute(Sender: TObject);
    procedure actCopyRepositoryExecute(Sender: TObject);
    procedure ActionfavorExecute(Sender: TObject);
    procedure ActionInputExecute(Sender: TObject);
  private
    FActionList: TActionList;
    FStdCateg: TStrings;
    FStateLock: Integer;
    FSelected: TList;
    FRespActions: TActionList;
    FRespImages: TImageList;
    FShowCaptions: Boolean;
    procedure AMDeferUpdate(var Msg: TMessage); message AM_DeferUpdate;
    procedure SetActionList(const Value: TActionList);
    procedure RegisteredAct(const Category: string; ActionClass:
      TBasicActionClass; Info: Pointer);
    function GetCategory: string;
    procedure MoveAction(OldIndex, NewIndex: integer);
    function AddAction(ActionClass: TBasicActionClass): TContainedAction;
    procedure SelectNew(Act: TComponent);
    procedure LoadRespository;
    function CopyAction(Dest: TActionList; Act: TCustomAction): TCustomAction;
    procedure PackRespImages;
    procedure PostUpdate(AType: integer);
    procedure SetShowCaptions(const Value: Boolean);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure UpdateList;
    procedure BuildActions;
    procedure BuildStdTree;
    procedure BuildRespositoryTree;
    procedure Activated; override;
    procedure UpdSelections;
    procedure GetSelections;
    procedure LockState;
    procedure UnlockState;
    procedure SaveLayout;
    procedure LoadLayout;
    function GetActionText(act: TContainedAction): string;
    procedure ActionToItem(act: TContainedAction; item: TListItem);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ItemsModified(const Designer: IDesigner); override;
    procedure DesignerClosed(const Designer: IDesigner; AGoingDormant: Boolean); override;
    procedure ItemDeleted(const ADesigner: IDesigner; Item: TPersistent); override;
    property ActionList: TActionList read FActionList write SetActionList;
    property Category: string read GetCategory;
    property ShowCaptions: Boolean read FShowCaptions write SetShowCaptions;
  end;

procedure ShowActListEditor(AActionList: TActionList; const ADesigner: IDesigner);
// Functions to handle drag&drop operations

function IsActionsSource(Source: TObject): Boolean;

function GetActions(Source: TObject; List: TList): integer;

procedure Register;

implementation

uses
  contnrs, CommCtrl, IniFiles;

{$R *.dfm}

var
  Editors: TList = nil; //uu,记录已经创建的编辑器
  Repository: TDataModule = nil;

procedure ShowActListEditor(AActionList: TActionList; const ADesigner: IDesigner);
var
  i: integer;
begin//uu,如果编辑器已经存在，就显示该编辑器，否则就创建一个编辑器
  if Editors <> nil then
    for i := 0 to Editors.Count - 1 do
      if TActionListEditor(Editors[i]).ActionList = AActionList then
        with TActionListEditor(Editors[i]) do
        begin
          Show;
          BringToFront;
          Exit;
        end;
  with TActionListEditor.Create(Application) do
  begin
    Designer := ADesigner;
    ActionList := AActionList;
    Show;
    BringToFront;
  end;
end;

function IsActionsSource(Source: TObject): Boolean;
begin//拖拽支持 Functions to handle drag&drop operations
  Result := (Source <> nil) and (Source is TListView) and (TListView(Source).Owner
    is TActionListEditor);
end;

function GetActions(Source: TObject; List: TList): integer;
var
  i: integer;
begin//uu,支持拖拽
  Result := 0;
  if IsActionsSource(Source) then
    with TListView(Source) do
      for i := 0 to Items.Count - 1 do
        if Items[i].Selected then
        begin
          if Assigned(List) then
            List.Add(Items[i].Data);
          Inc(Result);
        end;
end;

function CompareImgItems(ImgList: TCustomImageList; Index1, Index2: integer): Boolean;

  function CreateBmp(Index: integer): TBitmap;
  begin//uu,从imagelist返回一个bmp
    Result := TBitmap.Create;
    try
      Result.Width := ImgList.Width;
      Result.Height := ImgList.Height;
//      Result.Canvas.Brush.Color := clNone;
//      Result.Canvas.FillRect(Rect(0, 0, Result.Width, Result.Height));
      ImgList.Draw(Result.Canvas, 0, 0, Index);
    except
      Result.Free;
      raise;
    end;
  end;

var
  bmp1, bmp2: TBitmap;
  i, j: integer;
begin//uu,比较引用的两个图片是否一样
  bmp1 := CreateBmp(Index1);
  bmp2 := CreateBmp(Index2);
  Result := True;
  for i := 0 to ImgList.Width - 1 do
    for j := 0 to ImgList.Height - 1 do
      if bmp1.Canvas.Pixels[i, j] <> bmp2.Canvas.Pixels[i, j] then
      begin
        Result := False;
        Exit;
      end;
  bmp1.Free;
  bmp2.Free;
end;

function CheckLastImageUnique(ImgList: TCustomImageList): integer;
var
  i, lst: integer;
begin//uu,删除重复的图片，保证list中图片是唯一的。
  lst := ImgList.Count - 1;
  for i := 0 to ImgList.Count - 2 do
    if CompareImgItems(ImgList, i, lst) then
    begin
      ImgList.Delete(lst);
      Result := i;
      Exit;
    end;
  Result := lst;
end;

type
  TActionListCmpEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TActionHack = class(TCustomAction);

{ TActionListCmpEditor }

procedure TActionListCmpEditor.ExecuteVerb(Index: Integer);
begin//双击或右键菜单触发
  if Index = 0 then//uu,原来没有
    ShowActListEditor(TActionList(Component), Designer);
  //uu,创建并显示编辑器，其中维护一个list保存了已经创建的窗体
  //uu,可能出错
end;

function TActionListCmpEditor.GetVerb(Index: Integer): string;
begin
  Result := SActionListEdit;
end;

function TActionListCmpEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

procedure Register;
begin
  RegisterComponentEditor(TActionList, TActionListCmpEditor);
end;

{ TActionListEditor }

constructor TActionListEditor.Create(AOwner: TComponent);
begin
  if Editors = nil then//uu,创建一个list保存已经创建的编辑器
    Editors := TObjectList.Create;
  Editors.Add(Self);
  inherited;
  BuildStdTree; //uu,创建标准动作表ok
  FSelected := TList.Create; //uu,选中的action
  LoadRespository; //uu,收藏的动作ok
  LoadLayout; //uu,从ini读取窗体信息
  //uu,显示标题开关
  ActionShowCaptions.Checked := ShowCaptions;
//  ShowMessage('create!');调试方法：用 host application
end;

destructor TActionListEditor.Destroy;
begin
  if Assigned(Editors) then
    Editors.Extract(Self);
  FreeAndNil(FSelected);
  inherited;
end;

procedure TActionListEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  if FActionList <> nil then //uu,添加，如果删除ActionList就不能选了
    Designer.SelectComponent(FActionList);
  SaveLayout; //uu,信息保存到ini
end;

procedure TActionListEditor.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (AComponent = FActionList) and (Operation = opRemove) then
  begin//uu,删除对应的ActionList，就关闭
    FActionList := nil;
    Close;
  end;
end;

procedure TActionListEditor.SetActionList(const Value: TActionList);
begin
  if FActionList = Value then
    Exit;
  FActionList := Value;
  if Assigned(FActionList) then
  begin
    UpdateList;
    FActionList.FreeNotification(Self);
    ActListView.SmallImages := FActionList.Images;
    if FActionList.Owner <> nil then
      Caption := FActionList.Owner.Name + '.' + FActionList.Name;
  end
  else
    ActListView.SmallImages := nil;
end;

const
  IniSection = 'Action List Editor';

procedure TActionListEditor.LoadLayout;
begin
  with TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini')) do
  try
    Width := ReadInteger(IniSection, 'Width', Width);
    Height := ReadInteger(IniSection, 'Height', Height);
    Top := ReadInteger(IniSection, 'Top', Top); //uu,
    Left := ReadInteger(IniSection, 'Left', Left); //uu,
    PnlCategories.Width := ReadInteger(IniSection, 'CatWidth', PnlCategories.Width);
    PnlResources.Width := ReadInteger(IniSection, 'ResWidth', PnlResources.Width);
    PnlRespository.Height := ReadInteger(IniSection, 'RespHeight', PnlRespository.Height);
    ToolBar1.Visible := ReadBool(IniSection, 'Toolbar', ToolBar1.Visible);
    ShowCaptions := ReadBool(IniSection, 'ShowCaptions', ShowCaptions); //uu,
    ActionInput.Checked := ReadBool(IniSection, 'Input', ActionInput.Checked); //uu,
  finally
    Free;
  end;
end;

procedure TActionListEditor.SaveLayout;
begin
  with TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini')) do
  try
    EraseSection(IniSection);
    WriteInteger(IniSection, 'Width', Width);
    WriteInteger(IniSection, 'Height', Height);
    WriteInteger(IniSection, 'Top', Top); //uu,
    WriteInteger(IniSection, 'Left', Left); //uu,
    WriteInteger(IniSection, 'CatWidth', PnlCategories.Width);
    WriteInteger(IniSection, 'ResWidth', PnlResources.Width);
    WriteInteger(IniSection, 'RespHeight', PnlRespository.Height);
    WriteBool(IniSection, 'Toolbar', ToolBar1.Visible);
    WriteBool(IniSection, 'ShowCaptions', ShowCaptions); //uu,
    WriteBool(IniSection, 'Input', ActionInput.Checked); //uu,
  finally
    Free;
  end;
end;

// ============================================================================
//  Standard actions tree
// ============================================================================
procedure TActionListEditor.RegisteredAct(const Category: string; ActionClass:
  TBasicActionClass; Info: Pointer);
var
  idx: integer;
  cat: TTreeNode;
  S: string;
begin
  if FStdCateg <> nil then
  begin
    S := Category;
    if S = '' then
      S := SActionCategoryNone;
    idx := FStdCateg.IndexOf(S);
    if idx = -1 then
    begin
      cat := TV.Items.AddChild(nil, S);
      FStdCateg.AddObject(S, cat);
    end
    else
      cat := TTreeNode(FStdCateg.Objects[idx]);
    TV.Items.AddChild(cat, ActionClass.ClassName).Data := ActionClass;
  end;
end;

procedure TActionListEditor.BuildStdTree;
begin
  TV.Items.BeginUpdate;
  FStdCateg := TStringList.Create;
  try
    TV.Items.Clear;
    EnumRegisteredActions(RegisteredAct, nil);
  finally
    FreeAndNil(FStdCateg);
    TV.Items.EndUpdate;
  end;
end;

// ============================================================================
//  Filling lists and managing selections
// ============================================================================
procedure TActionListEditor.LockState;
begin
  Inc(FStateLock);
end;

procedure TActionListEditor.UnlockState;
begin
  Dec(FStateLock);
end;

procedure TActionListEditor.UpdSelections;
var
  Sel: IDesignerSelections;
  i: integer;
begin
  FSelected.Clear;
  if FActionList = nil then
    Exit;
  Sel := CreateSelectionList;
  if ActListView.SelCount = 0 then
    Sel.Add(FActionList)
  else
    for i := 0 to ActListView.Items.Count - 1 do
      if ActListView.Items[i].Selected then
      begin
        FSelected.Add(ActListView.Items[i].Data);
        Sel.Add(TComponent(ActListView.Items[i].Data));
      end;
  SetSelection(Sel);
end;

procedure TActionListEditor.GetSelections;
var
  Sel: IDesignerSelections;
  i: integer;
begin
  Sel := CreateSelectionList;
  Designer.GetSelections(Sel);
  with ActListView do
  begin
    LockState;
    Items.BeginUpdate;
    Selected := nil;
    try
//        if (Sel.Count <> 1) or ((Sel[0] <> FActionList)) then Exit;//uu,？？
      for i := 0 to Items.Count - 1 do
        Items[i].Selected := FSelected.IndexOf(Items[i].Data) <> -1;
    finally
      Items.EndUpdate;
      UnlockState;
    end;
  end;
end;

procedure TActionListEditor.AMDeferUpdate(var Msg: TMessage);
begin
  if FStateLock = 0 then
  begin
    if Msg.WParam = 0 then
      UpdSelections
    else
      UpdateList;
  end
  else
    PostUpdate(Msg.WParam);
end;

procedure TActionListEditor.ActListViewChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  if not (csDestroying in ComponentState) and (FStateLock = 0) and (Change = ctState) then
  begin
    PostUpdate(0);
  end;
end;

procedure TActionListEditor.BuildActions;
var
  S: string;
  All: Boolean;
  i: integer;
  it: TListItem;
begin
  with ActListView.Items do
  begin
    LockState;
    BeginUpdate;
    try
      Clear;
      if FActionList = nil then
        Exit;
      if CatList.ItemIndex = -1 then//uu,没有选中的组，就不显示任何
        Exit;
      S := '';
      All := False;
      case integer(CatList.Items.Objects[CatList.ItemIndex]) of
        0: //uu,分组显示
          S := CatList.Items[CatList.ItemIndex];
//        1://uu,显示无分组？？？
        2: //uu,显示所有
          All := True;
      end;
      for i := 0 to FActionList.ActionCount - 1 do
        if All or (FActionList[i].Category = S) then
        begin
          it := Add;
          ActionToItem(FActionList[i], it);
        end;
//          with Add do
//          begin
//            Caption := GetActionText(FActionList[i]);
//            Data := FActionList[i];
//            if FActionList[i] is TCustomAction then
//              ImageIndex := TCustomAction(FActionList[i]).ImageIndex;
//          end;
    finally
      EndUpdate;
//      GetSelections;//uu,？？
      UnlockState;
    end;
  end;
end;

function TActionListEditor.GetCategory: string;
begin
  if (CatList.ItemIndex = -1) or (CatList.Items.Objects[CatList.ItemIndex] <> nil) then
    Result := ''
  else
    Result := CatList.Items[CatList.ItemIndex];
end;

procedure TActionListEditor.UpdateList;
var//uu,更新Action列表
  i, idx: integer;
  S, Sel: string;
  HasNoCat: Boolean;
  St: TStringList;
begin
  // Remember selected
  if CatList.ItemIndex = -1 then
    Sel := ''
  else
    Sel := CatList.Items[CatList.ItemIndex]; //uu,获得选择的组名

  St := TStringList.Create; //uu,组名列表
  St.Sorted := True; //uu,排序，方法是默认的？

  LockState;
  try
    if FActionList <> nil then
    begin
      HasNoCat := False;
      for i := 0 to FActionList.ActionCount - 1 do
      begin
        S := FActionList.Actions[i].Category;
        if S = '' then
          HasNoCat := True
        else
        begin
          idx := St.IndexOf(S);
          if idx = -1 then
            St.Add(S); //uu,没有重复的就添加到列表
        end;
      end;

      St.Sorted := False;
      if HasNoCat then//uu,存在没有组名的，就插入到第一个
        St.InsertObject(0, SActionCategoryNone, TObject(1));
      if St.Count > 1 then//uu,组名数量大于1，也就是action大于0，添加一个所有acting的分类
        St.AddObject(SActionCategoryAll, TObject(2));

//      idx := St.IndexOf(Sel);
//      CatList.ItemIndex := idx;//uu,恢复选择的组名

//      CatList.Items := St; //uu,是不是要先更新？和下面的重复了！！！
      CatList.Items.Assign(St);
      idx := CatList.Items.IndexOf(Sel); //uu,先更新，再找原来选择的
      if idx = -1 then
        idx := 0;
      if idx < CatList.Items.Count then
        CatList.ItemIndex := idx;
      BuildActions;
    end;
  finally
    UnlockState;
    St.Free;
  end;
end;

procedure TActionListEditor.CatListClick(Sender: TObject);
begin
  BuildActions;
end;

procedure TActionListEditor.FormKeyPress(Sender: TObject; var Key: Char);
begin
  ActivateInspector(Key);
end;

procedure TActionListEditor.actDeleteUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := ActListView.SelCount > 0;
end;

procedure TActionListEditor.actDeleteExecute(Sender: TObject);
var
  i: integer;
  Act: TObject;
begin
  LockState;
  try
    for i := ActListView.Items.Count - 1 downto 0 do
      if ActListView.Items[i].Selected then
      begin
        Act := TObject(ActListView.Items[i].Data);
        ActListView.Items[i].Delete;
        Act.Free;
        Designer.Modified;
      end;
    FSelected.Clear;
    if ActListView.Items.Count = 0 then
      UpdateList;
    UpdSelections;
  finally
    UnlockState;
  end;
end;

procedure TActionListEditor.ActListViewDblClick(Sender: TObject);
var
  Editor: IComponentEditor;
begin
  if ActListView.Selected <> nil then
  begin
    Editor := TDefaultEditor.Create(TComponent(ActListView.Selected.Data), Designer);
    Editor.Edit; //uu,创建action编辑器，并编辑
  end;
end;

procedure TActionListEditor.Activated;
begin
  inherited;
  PostUpdate(0);
end;

function TActionListEditor.AddAction(ActionClass: TBasicActionClass): TContainedAction;

  function getX(const strInput: string; const intIndex: Integer): string;
  var
    n, p, ii, ll: Integer;
    str1: string;
  const
    spChar = ';';
    spBigChar = '；';
  begin
    if strInput = '' then
    begin
      Result := '';
      Exit;
    end;
    str1 := StringReplace(strInput, spBigChar, spChar, [rfReplaceAll]);
    n := 0;
    p := 0;
    ll := Length(str1);
    for ii := 1 to ll do
    begin
      if str1[ii] = spChar then
      begin
        if n = intIndex then//xxx;ccc;ddd;eee。如果n=0，返回xxx
        begin
          Result := Copy(str1, p + 1, ii - p - 1);
          Exit;
        end
        else
        begin
          inc(n);
          p := ii;
        end;
      end;
    end;
    if (p < ll) and (n = intIndex) then//如果x=3，返回eee
      Result := Copy(str1, p + 1, ll - p + 1)
    else
      Result := '';
  end;

  function lastIntPos(const Name: string): integer;
  var
    I: Integer;
  begin
    result := -1;
    for I := length(Name) downto 1 do
      if CharInSet(Name[I], ['0'..'9']) then
        result := I
      else
        Break;
  end;

  function formatName(const Name: string): string;
  var
//    x,
    p: integer;
    left, right: string;
  begin
    result := Name;
    p := lastintpos(Name);
    if p > 0 then
    begin
      left := copy(Name, 1, p - 1);
      right := copy(Name, p, length(Name) - p + 1);
      result := format('%s%.3d', [left, strtoint(right)]);
    end;
  end;

var
  newAct: TAction;
  strDefault, strInput, strName, strCaption,  {strCat,} strImg, strHint: string;
  img, code: Integer;
begin
  if not ActionClass.InheritsFrom(TContainedAction) then
    raise Exception.Create('Action is not of TContainedAction class');
//uu,  Result := TContainedAction(VCLEditors.CreateAction(FActionList.Owner, ActionClass));
  Result := TContainedAction(CreateAction(FActionList.Owner, ActionClass));
  Result.ActionList := FActionList; //uu,归入那个list
  Result.Name := UniqueName(Result); //uu,从IDE获取一个自动命名的唯一存在的名字
  if Result is TAction then
  begin
    newAct := TAction(Result);
    if newAct = nil then
      raise Exception.Create('添加Action出错！');
//    newAct.Category := Category;
//uu,设置分类，在NewAction中已经设置了，如果是标准Action，就不要设置
//    strName := newAct.Name; //uu,补足序号位数
//    newAct.Name := formatName(strName);//uu,总是创建 Action1
    newAct.Name := format('%s%.3d', ['act', newAct.ComponentIndex]);
    if ActionInput.Checked then//uu,如果选择新建时输入标题的属性
    begin
      strCaption := newAct.Caption;
      strHint := newAct.Hint;
//    strCat:= newAct.Category;
      strName := newAct.Name;
      strImg := IntToStr(newAct.ImageIndex);
      strDefault := Format('%s;%s;%s;%s', [strCaption, strHint, strName, strImg]);
      strInput := InputBox('设置属性：', '格式：Caption;Hint;Name;ImageIndex', strDefault);
      if strInput <> strDefault then
      begin
        strCaption := getX(strInput, 0);
        strHint := getX(strInput, 1);
        strName := getX(strInput, 2);
        strImg := getX(strInput, 3);
//    strCat := getX(strInput, 4);
        if strName <> '' then
          newAct.Name := strName;
        if strCaption <> '' then
          newAct.Caption := strCaption;
//    newAct.Category := strCat;
        if strHint <> '' then
          newAct.Hint := strHint;
        if strImg <> '' then
        begin
          Val(strImg, img, code);
          if code = 0 then
            newAct.ImageIndex := img;
        end;
//        SelectNew(newAct);
//      PostUpdate(1);//uu,不能更新属性编辑器，selectNew中会更新
      end;
    end;
  end;
{//uu,原来的设置图片
  if Result is TCustomAction then
    with TActionHack(Result) do
      if (FImage <> nil) and (ActListView.SmallImages <> nil) then
      begin//uu,显示图片
        LockState;
        try
          ActListView.SmallImages.Add(TBitmap(FImage), TBitmap(FMask));
        finally
          UnlockState;
        end;
        ImageIndex := CheckLastImageUnique(ActListView.SmallImages);
      end;
}
  SelectNew(Result);
  Designer.Modified;
end;

procedure TActionListEditor.SelectNew(Act: TComponent);
begin
  FSelected.Clear;
  FSelected.Add(Act);
  Designer.SelectComponent(Act);
  PostUpdate(1); //uu,更新Action列表
end;

procedure TActionListEditor.actNewExecute(Sender: TObject);
begin
  AddAction(TAction).Category := Category; //uu,原来的代码只设置分类
end;

procedure TActionListEditor.ActListViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_DELETE:
      actDelete.Execute;
    VK_INSERT:
      actNew.Execute;
  end;
end;

procedure TActionListEditor.actPasteUpdate(Sender: TObject);
begin
  actPaste.Enabled := Designer.CanPaste;
end;

procedure TActionListEditor.actCutExecute(Sender: TObject);
begin
  if actCopy.Execute then
    actDelete.Execute;
end;

procedure TActionListEditor.actSelectAllUpdate(Sender: TObject);
begin
  actSelectAll.Enabled := ActListView.Items.Count > ActListView.SelCount;
end;

procedure TActionListEditor.actCopyExecute(Sender: TObject);
var
  Sel: IDesignerSelections;
  i: integer;
begin
  Sel := CreateSelectionList;
  for i := 0 to ActListView.Items.Count - 1 do
    if ActListView.Items[i].Selected then
      Sel.Add(TComponent(ActListView.Items[i].Data));
  if Sel.Count > 0 then
    CopyComponents(FActionList.Owner, Sel);
end;

procedure TActionListEditor.actSelectAllExecute(Sender: TObject);
begin
  ActListView.SelectAll;
  UpdSelections;
end;

procedure TActionListEditor.actPasteExecute(Sender: TObject);
var
  Sel: IDesignerSelections;
  i: integer;
  Cat: string;
  ChangeCat: Boolean;
begin
  ChangeCat := True;
  if CatList.ItemIndex = -1 then
    ChangeCat := False
  else
    case integer(CatList.Items.Objects[CatList.ItemIndex]) of
      0:
        Cat := CatList.Items[CatList.ItemIndex];
      1:
        Cat := '';
    else
      ChangeCat := False;
    end;

  Sel := CreateSelectionList;
  PasteComponents(FActionList.Owner, FActionList, Sel);
  FSelected.Clear;
  for i := 0 to Sel.Count - 1 do
    if (Sel[i] <> nil) and (Sel[i] is TCustomAction) and (TContainedAction(Sel[i]).ActionList
      = FActionList) then
    begin
      FSelected.Add(Sel[i]);
      if ChangeCat then
        TContainedAction(Sel[i]).Category := Cat;
    end;
  PostUpdate(1);
end;

procedure TActionListEditor.ActListViewEnter(Sender: TObject);

  procedure UpdLblColor(Lbl: TLabel);
  begin
    with Lbl do
      if FocusControl = ActiveControl then
        Color := clActiveCaption
      else
        Color := clInactiveCaption;
  end;

begin
  UpdLblColor(Label1);
  UpdLblColor(Label2);
  UpdLblColor(Label3);
  UpdLblColor(Label4);
end;

// ============================================================================
//  Moving actions
// ============================================================================

procedure TActionListEditor.MoveAction(OldIndex, NewIndex: integer);
begin
  TCustomAction(ActListView.Items[OldIndex].Data).Index := TCustomAction(ActListView.Items
    [NewIndex].Data).Index;
  PostUpdate(1);
end;

procedure TActionListEditor.actMoveUpUpdate(Sender: TObject);
begin
  actMoveUp.Enabled := (ActListView.Selected <> nil) and (ActListView.Selected.Index > 0);
end;

procedure TActionListEditor.actMoveDownUpdate(Sender: TObject);
begin
  actMoveDown.Enabled := (ActListView.Selected <> nil) and (ActListView.Selected.Index
    < ActListView.Items.Count - 1);
end;

procedure TActionListEditor.actMoveUpExecute(Sender: TObject);
var
  idx: integer;
begin
  idx := ActListView.Selected.Index;
  MoveAction(idx, idx - 1);
end;

procedure TActionListEditor.actMoveDownExecute(Sender: TObject);
var
  idx: integer;
begin
  idx := ActListView.Selected.Index;
  MoveAction(idx, idx + 1);
end;

procedure TActionListEditor.ActListViewDragOver(Sender, Source: TObject; X, Y:
  Integer; State: TDragState; var Accept: Boolean);
var
  li: TListItem;
begin
  li := ActListView.GetItemAt(X, Y);
  Accept := (Source = ActListView) and (ActListView.SelCount = 1) and (li <> nil)
    and (li <> ActListView.Selected) or (Source = TV) or (Source = TVRes);
end;

procedure TActionListEditor.ActListViewDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  li: TListItem;
  Act: TContainedAction;
begin
  li := ActListView.GetItemAt(X, Y);
  if Source = ActListView then
    MoveAction(ActListView.Selected.Index, li.Index)
  else
  begin
    if Source = TV then
      Act := AddAction(TBasicActionClass(TV.Selected.Data))
    else if Source = TVRes then
    begin
      Act := CopyAction(FActionList, TCustomAction(TVRes.Selected.Data));
      SelectNew(Act);
    end
    else
      Exit;

    Act.Category := Category;
    if li <> nil then
      Act.Index := TContainedAction(li.Data).Index;
    PostUpdate(1);
  end;
end;

procedure TActionListEditor.CatListDragOver(Sender, Source: TObject; X, Y:
  Integer; State: TDragState; var Accept: Boolean);
var
  idx: integer;
begin
  idx := CatList.ItemAtPos(Point(X, Y), True);
  Accept := (idx <> -1) and (Source = ActListView) and (ActListView.SelCount > 0)
    and (idx <> CatList.ItemIndex);
end;

procedure TActionListEditor.CatListDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  i, idx: integer;
  S: string;
begin
  idx := CatList.ItemAtPos(Point(X, Y), True);
  case integer(CatList.Items.Objects[idx]) of
    0:
      S := CatList.Items[idx];
    1:
      S := '';
  else
    Exit;
  end;
  for i := 0 to FSelected.Count - 1 do
    TContainedAction(FSelected[i]).Category := S;
  CatList.ItemIndex := idx;
  BuildActions;
//  GetSelections;
//  PostMessage(Handle, AM_DeferUpdate, 1, 0);
end;

procedure TActionListEditor.actCopyStandardUpdate(Sender: TObject);
begin
  actCopyStandard.Enabled := (TV.Selected <> nil) and (TV.Selected.Data <> nil);
end;

procedure TActionListEditor.actCopyStandardExecute(Sender: TObject);
begin
  if (TV.Selected <> nil) and (TV.Selected.Data <> nil) then//uu,增加判断
  begin
    AddAction(TBasicActionClass(TV.Selected.Data)).Category := TV.Selected.Parent.Text;
    PostUpdate(1);
  end
  else
    ShowMessage('先选择一个标准Action！');
end;

procedure TActionListEditor.TVStartDrag(Sender: TObject; var DragObject: TDragObject);
begin
  with Sender as TTreeView do
    if (Selected = nil) or (Selected.Data = nil) then
      CancelDrag;
end;

procedure TActionListEditor.Label1Click(Sender: TObject);
begin
  with TLabel(Sender).FocusControl do
    if not Focused then
      SetFocus;
end;

// ============================================================================
//  Processing Repository
// ============================================================================
const
  SRespositoryResFile = 'ActionsRespository.dfm';

procedure TActionListEditor.LoadRespository;
var
  Fn: string;
  IL: TImageList;
  AL: TActionList;

  function DoLoad: Boolean;
  var
    St: TStream;
  begin
    Result := True;
    try
      St := TFileStream.Create(Fn, fmOpenRead);
      try
        St.ReadComponent(Repository);
        IL := TImageList(Repository.FindComponent('ImageList1'));
        if not Assigned(IL) or not (IL is TImageList) then
          raise Exception.Create('Image list is not found');
        AL := TActionList(Repository.FindComponent('ActionList1'));
        if not Assigned(AL) or not (AL is TActionList) then
          raise Exception.Create('Action list is not found');
      finally
        St.Free;
      end;
    except
      Result := False;
      Application.HandleException(Self);
      FreeAndNil(Repository);
      Repository := TDataModule.Create(nil);
    end;
  end;

begin
  if Repository = nil then
  begin
    Repository := TDataModule.Create(nil);
    Fn := ExtractFilePath(Application.ExeName) + SRespositoryResFile;
    if not FileExists(Fn) or not DoLoad then
    begin
      IL := TImageList.Create(Repository);
      IL.Name := 'ImageList1';
      AL := TActionList.Create(Repository);
      AL.Name := 'ActionList1';
      AL.Images := IL;
    end;
  end;
  FRespActions := Repository.FindComponent('ActionList1') as TActionList;
  FRespImages := Repository.FindComponent('ImageList1') as TImageList;
  TVRes.Images := FRespImages;
  BuildRespositoryTree;
end;

procedure SaveRespository;
var
  St: TStream;
  Fn: string;
  FRespActions: TActionList;
begin
  if not Assigned(Repository) then
    Exit;
  Fn := ExtractFilePath(Application.ExeName) + SRespositoryResFile;
  FRespActions := Repository.FindComponent('ActionList1') as TActionList;
  if FRespActions.ActionCount > 0 then
  begin
    St := TFileStream.Create(Fn, fmCreate);
    try
      St.WriteComponent(Repository);
    finally
      St.Free;
    end;
  end
  else
  begin
    if FileExists(Fn) then
      DeleteFile(Fn);
  end;
end;

procedure TActionListEditor.BuildRespositoryTree;
var
  Cat, Exp: TStrings;
  Sel: string;
  i: integer;
  tn: TTreeNode;

  function GetCat(S: string): TTreeNode;
  var
    idx: integer;
  begin
    if S = '' then
      S := SActionCategoryNone;
    idx := Cat.IndexOf(S);
    if idx <> -1 then
      Result := TTreeNode(Cat.Objects[idx])
    else
    begin
      Result := TVRes.Items.AddChild(nil, S);
      Result.ImageIndex := -1;
      Result.SelectedIndex := -1;
      Cat.AddObject(S, Result);
    end;
  end;

begin
  Cat := TStringList.Create;
  Exp := TStringList.Create;
  ;
  TStringList(Cat).Sorted := True;
  TStringList(Exp).Sorted := True;
  TVRes.Items.BeginUpdate;
  try
    // Saving state
    if TVRes.Selected <> nil then
      Sel := TVRes.Selected.Text
    else
      Sel := '';
    for i := 0 to TVRes.Items.Count - 1 do
      if TVRes.Items[i].Expanded then
        Exp.Add(TVRes.Items[i].Text);

    TVRes.Items.Clear;
    if FRespActions <> nil then
      for i := 0 to FRespActions.ActionCount - 1 do
        with FRespActions[i] do
        begin
          tn := TVRes.Items.AddChild(GetCat(Category), GetActionText(FRespActions[i]));
          tn.Data := FRespActions[i];
          if FRespActions[i] is TCustomAction then
            with TCustomAction(FRespActions[i]) do
            begin
              tn.ImageIndex := ImageIndex;
              tn.SelectedIndex := ImageIndex;
            end;
        end;
    // Restore state
    for i := 0 to TVRes.Items.Count - 1 do
      with TVRes.Items[i] do
      begin
        if Exp.IndexOf(Text) <> -1 then
          Expand(False);
        if (Sel <> '') and (Text = Sel) then
          Selected := True;
      end;
  finally
    TVRes.Items.EndUpdate;
    Cat.Free;
    Exp.Free;
  end;
end;

procedure TActionListEditor.TVResDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  tn: TTreeNode;
begin
  tn := TVRes.GetNodeAt(X, Y);
  Accept := (Source = ActListView) or (Source = TVRes) and (tn <> nil) and (tn
    <> TVRes.Selected);
end;

procedure TActionListEditor.TVResDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  tn: TTreeNode;
  i: integer;
  act: TContainedAction;
begin
  tn := TVRes.GetNodeAt(X, Y);
  if Source = TVRes then
    with TContainedAction(TVRes.Selected.Data) do
    begin
      if tn.Data = nil then
      begin
        if tn.Text = SActionCategoryNone then
          Category := ''
        else
          Category := tn.Text;
      end
      else
      begin
        Index := TContainedAction(tn.Data).Index;
        Category := TContainedAction(tn.Data).Category;
      end;
// Deleted by Administrator 2017/9/24 10:18:34      BuildRespositoryTree;
    end
  else
    for i := ActListView.Items.Count - 1 downto 0 do
      if ActListView.Items[i].Selected then
      begin
        act := TContainedAction(ActListView.Items[i].Data);
        act := CopyAction(FRespActions, act as TCustomAction);
        if tn <> nil then
        begin
          if tn.Data <> nil then
            with TContainedAction(tn.Data) do
            begin
              act.Index := Index;
              act.Category := Category;
            end
          else if tn.Text = SActionCategoryNone then
            act.Category := ''
          else
            act.Category := tn.Text;
        end;
      end;
  BuildRespositoryTree;
end;

function TActionListEditor.CopyAction(Dest: TActionList; Act: TCustomAction):
  TCustomAction;
var
  Image, Mask: TBitmap;

  procedure CreateMaskedBmp(ImageList: TCustomImageList; ImageIndex: Integer);
  begin
    Image := Graphics.TBitmap.Create;
    Mask := Graphics.TBitmap.Create;
    try
      with Image do
      begin
        Height := ImageList.Height;
        Width := ImageList.Width;
      end;
      with Mask do
      begin
        Monochrome := True;
        Height := ImageList.Height;
        Width := ImageList.Width;
      end;
      ImageList_Draw(ImageList.Handle, ImageIndex, Image.Canvas.Handle, 0, 0, ILD_NORMAL);
      ImageList_Draw(ImageList.Handle, ImageIndex, Mask.Canvas.Handle, 0, 0, ILD_MASK);
    except
      Image.Free;
      Mask.Free;
      Image := nil;
      Mask := nil;
      raise;
    end;
  end;

  function UniqueName(const Base: string): string;
  var
    i: integer;
  begin
    Result := Base;
    if Dest.Owner.FindComponent(Result) = nil then
      Exit;
    i := 1;
    repeat
      Result := Base + IntToStr(i);
      Inc(i);
    until Dest.Owner.FindComponent(Result) = nil;
  end;

begin
  Result := TCustomAction(TContainedActionClass(Act.ClassType).Create(Dest.Owner));
  Result.ActionList := Dest;
  with Result do
  begin
    Name := UniqueName(Act.Name);
    Caption := Act.Caption;
    Checked := Act.Checked;
    Enabled := Act.Enabled;
    HelpContext := Act.HelpContext;
    Hint := Act.Hint;
    ImageIndex := Act.ImageIndex;
    ShortCut := Act.ShortCut;
    Visible := Act.Visible;
    Category := Act.Category;
    if (Act.ImageIndex > -1) and (Act.ActionList <> nil) and (Act.ActionList.Images
      <> nil) and (Dest.Images <> nil) then
    begin
      CreateMaskedBmp(Act.ActionList.Images, Act.ImageIndex);
      try
        Dest.Images.Add(Image, Mask);
      finally
        Image.Free;
        Mask.Free;
      end;
      ImageIndex := CheckLastImageUnique(Dest.Images);
    end;
  end;
end;

procedure TActionListEditor.TVResChange(Sender: TObject; Node: TTreeNode);
begin
  if TVRes.Focused and (TVRes.Selected <> nil) and (TVRes.Selected.Data <> nil) then
    Designer.SelectComponent(TComponent(TVRes.Selected.Data));
end;

procedure TActionListEditor.TVResEnter(Sender: TObject);
begin
  ActListViewEnter(Sender);
  TVResChange(Sender, TVRes.Selected);
end;

procedure TActionListEditor.TVResExit(Sender: TObject);
begin
  PostUpdate(0);
end;

procedure TActionListEditor.PackRespImages;

  function IsUsed(Index: integer): Boolean;
  var
    i: integer;
  begin
    for i := 0 to FRespActions.ActionCount - 1 do
      if (FRespActions[i] as TCustomAction).ImageIndex = Index then
      begin
        Result := True;
        Exit;
      end;
    Result := False;
  end;

  procedure DecIndexes(Index: integer);
  var
    i: integer;
  begin
    for i := 0 to FRespActions.ActionCount - 1 do
      with FRespActions[i] as TCustomAction do
        if ImageIndex > Index then
          ImageIndex := ImageIndex - 1;
    for i := 0 to TVRes.Items.Count - 1 do
      with TVRes.Items[i] do
        if ImageIndex > Index then
        begin
          ImageIndex := ImageIndex - 1;
          SelectedIndex := ImageIndex;
        end;
  end;

var
  i: integer;
begin
  for i := FRespImages.Count - 1 downto 0 do
    if not IsUsed(i) then
    begin
      FRespImages.Delete(i);
      DecIndexes(i);
    end;
end;

procedure TActionListEditor.actDelRepositoryUpdate(Sender: TObject);
begin
  actDelRepository.Enabled := (TVRes.Selected <> nil) and (TVRes.Selected.Data <> nil);
end;

procedure TActionListEditor.actDelRepositoryExecute(Sender: TObject);
var
  Cmp: TComponent;
begin
  Cmp := TComponent(TVRes.Selected.Data);
  if (TVRes.Selected.Parent <> nil) and (TVRes.Selected.Parent.Count = 1) then
    TVRes.Selected.Parent.Delete
  else
    TVRes.Selected.Delete;
  Designer.SelectComponent(FActionList);
  Cmp.Free;
  TVResChange(Sender, TVRes.Selected);
  PackRespImages;
end;

procedure TActionListEditor.TVResKeyDown(Sender: TObject; var Key: Word; Shift:
  TShiftState);
begin
  if Key = VK_DELETE then
    actDelRepository.Execute;
end;

procedure TActionListEditor.PostUpdate(AType: integer);
var
  Msg: TMsg;
begin
  if PeekMessage(Msg, Handle, AM_DeferUpdate, AM_DeferUpdate, PM_REMOVE) and (AType
    < Msg.wParam) then
    AType := Msg.wParam;
  PostMessage(Handle, AM_DeferUpdate, AType, 0);
end;

procedure TActionListEditor.TVResCustomDrawItem(Sender: TCustomTreeView; Node:
  TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  with TTreeView(Sender).Canvas.Font do
    if Node.Data = nil then
      Style := [fsBold]
    else
      Style := [];
end;

procedure TActionListEditor.actShowToolbarUpdate(Sender: TObject);
begin
  actShowToolbar.Checked := ToolBar1.Visible;
end;

procedure TActionListEditor.actShowToolbarExecute(Sender: TObject);
begin
  ToolBar1.Visible := not ToolBar1.Visible;
end;

procedure TActionListEditor.ActionShowCaptionsUpdate(Sender: TObject);
begin
  ActionShowCaptions.Checked := ShowCaptions;
end;

procedure TActionListEditor.SetShowCaptions(const Value: Boolean);
begin
  if FShowCaptions = Value then
    Exit;
  FShowCaptions := Value;
  if FActionList = nil then
    Exit;
  BuildActions;
  BuildRespositoryTree;
end;

procedure TActionListEditor.ActionShowCaptionsExecute(Sender: TObject);
begin
  ShowCaptions := not ShowCaptions;
  //uu,
  with Sender as TAction do
    Checked := ShowCaptions;
end;

function TActionListEditor.GetActionText(act: TContainedAction): string;
var
  cAct: TCustomAction;
begin
  if act is TCustomAction then
  begin
    cAct := (act as TCustomAction);
//    strShortCut := ShortCutToText(cAct.ShortCut);
    if ShowCaptions then
      Result := Format('%-24.24s %-16.16s %s', [cAct.Caption, act.Name,
        ShortCutToText(cAct.ShortCut)])
    else
      Result := Format('%-24.24s %-16.16s', [act.Name, ShortCutToText(cAct.ShortCut)])
  end
  else
    Result := act.Name;
//  if ShowCaptions and (act is TCustomAction) then
//    Result := Format('%s(%s)(%s)', [TCustomAction(act).Caption, act.Name])
//  else
//    Result := act.Name;
end;

procedure TActionListEditor.TVDblClick(Sender: TObject);
begin
  actCopyStandard.Execute;
end;

procedure TActionListEditor.actExpandAllUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (ActiveControl <> nil) and (ActiveControl is
    TTreeView) and (TTreeView(ActiveControl).Items.Count > 1);
end;

procedure TActionListEditor.actExpandAllExecute(Sender: TObject);
var
  i: integer;
begin
  with TTreeView(ActiveControl).Items do
    for i := 0 to Count - 1 do
      Item[i].Expand(False);
end;

procedure TActionListEditor.actCollapseAllExecute(Sender: TObject);
var
  i: integer;
begin
  with TTreeView(ActiveControl).Items do
    for i := 0 to Count - 1 do
      Item[i].Collapse(False);
end;

procedure TActionListEditor.actCopyRepositoryExecute(Sender: TObject);
var
  Act: TCustomAction;
begin
  Act := CopyAction(FActionList, TCustomAction(TVRes.Selected.Data));
  SelectNew(Act);
  PostUpdate(1);
end;

procedure TActionListEditor.ItemsModified(const Designer: IDesigner);
var
  Sel: IDesignerSelections;
begin
  inherited;
  Sel := CreateSelectionList;
  Self.Designer.GetSelections(Sel);
  if (Sel.Count > 0) and (Sel[0] is TCustomAction) and (TCustomAction(Sel[0]).ActionList
    = FRespActions) then
    BuildRespositoryTree
  else
    UpdateList; //PostUpdate(1);
end;

procedure TActionListEditor.DesignerClosed(const Designer: IDesigner;
  AGoingDormant: Boolean);
begin
  inherited;
  Close;
end;

procedure TActionListEditor.ItemDeleted(const ADesigner: IDesigner; Item: TPersistent);
begin
  inherited;
  if (Item <> nil) and (Item is TBasicAction) then
    UpdateList;
end;

procedure TActionListEditor.ActionfavorExecute(Sender: TObject);
var
  tn: TTreeNode;
  i: integer;
  act: TContainedAction;
begin
  tn := TVRes.Selected;
  if tn = nil then
    tn := TVRes.TopItem; // .GetNodeAt(X, Y);
  for i := ActListView.Items.Count - 1 downto 0 do
    if ActListView.Items[i].Selected then
    begin
      act := TContainedAction(ActListView.Items[i].Data);
      act := CopyAction(FRespActions, act as TCustomAction);
      if tn <> nil then
      begin
        if tn.Data <> nil then
          with TContainedAction(tn.Data) do
          begin
            act.Index := Index;
            act.Category := Category;
          end
        else if tn.Text = SActionCategoryNone then
          act.Category := ''
        else
          act.Category := tn.Text;
      end;
    end;
  BuildRespositoryTree;
end;

procedure TActionListEditor.ActionInputExecute(Sender: TObject);
begin
  ActionInput.Checked := not ActionInput.Checked;
end;

procedure TActionListEditor.ActionToItem(act: TContainedAction; item: TListItem);
var
  cAct: TCustomAction;
begin
  item.Caption := act.Name;
  item.Data := act;
  if act is TCustomAction then
  begin
    cAct := (act as TCustomAction);
    if ShowCaptions then
      item.SubItems.Add(cAct.Caption)
    else
      item.SubItems.Add('');
    item.SubItems.Add(ShortCutToText(cAct.ShortCut));
    item.SubItems.Add(IntToStr(cAct.ImageIndex));
    item.ImageIndex := cAct.ImageIndex;
  end;
end;

initialization

finalization
  FreeAndNil(Editors);
  SaveRespository;
  FreeAndNil(Repository);

end.

