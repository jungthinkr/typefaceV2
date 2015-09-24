
#import "enterNumberViewController.h"
#import <Parse/Parse.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface enterNumberViewController ()
{
    NSArray *pickerArray;
    NSString *countrycode;

}
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;
@property (weak, nonatomic) IBOutlet UITextField *countryTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginnum;
@property (weak, nonatomic) IBOutlet UIButton *registernum;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UITextField *verificationTextField;
@property (weak, nonatomic) IBOutlet UIButton *entercode;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@end

@implementation enterNumberViewController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    _picker.hidden = YES;
    _entercode.hidden = YES;
    _backButton.hidden = YES;
    _verificationTextField.hidden = YES;
   
    pickerArray = @[@"USA",
                    @"AFGHANISTAN",
                    @"ALBANIA",
                    @"ALGERIA",
                    @"AMERICAN SAMOA",
                    @"ANDORRA",
                    @"ANGOLA",
                    @"ANGUILLA",
                    @"ANTARCTICA",
                    @"ANTIGUIA AND BARBUDA",
                    @"ARGENTINA",
                    @"ARMENIA",
                    @"ARUBA",
                    @"AUSTRALIA",
                    @"AUSTRIA",
                    @"AZERBAIJAN",
                    @"BAHAMAS",
                    @"BAHRAIN",
                    @"BANGLADESH",
                    @"BARBADOS",
                    @"BELARUS",
                    @"BELGIUM",
                    @"BELIZE",
                    @"BENIN",
                    @"BERMUDA",
                    @"BHUTAN",
                    @"BOLIVIA",
                    @"BOSNIA AND HERZEGOVINA",
                    @"BOTSWANA",
                    @"BRAZIL",
                    @"BRITISH INDIAN OCEAN TERRITORY",
                    @"BRITISH VIRGIN ISLANDS",
                    @"BRUNEI",
                    @"BULGARIA",
                    @"BURKINA FASO",
                    @"BURUNDI",
                    @"CAMBODIA",
                    @"CAMEROON",
                    @"CANADA",
                    @"CAPE VERDE",
                    @"CAYMAN ISLANDS",
                    @"CENTRAL AFRICAN REPUBLIC",
                    @"CHAD",
                    @"CHILE",
                    @"CHINA",
                    @"CHRISTMAS ISLAND",
                    @"COCOS ISLANDS",
                    @"COLOMBIA",
                    @"COMOROS",
                    @"COOK ISLANDS",
                    @"COSTA RICA",
                    @"CROATIA",
                    @"CUBA",
                    @"CURACAO",
                    @"CYPRUS",
                    @"CZECH REPUBLIC",
                    @"DEMOCRATIC REPUBLIC OF THE CONGO",
                    @"DENMARK",
                    @"DJIBOUTI",
                    @"DOMINICA",
                    @"DOMINICAN REPUBLIC",
                    @"EAST TIMOR",
                    @"ECUADOR",
                    @"EGYPT",
                    @"EL SALVADOR",
                    @"EQUATORIAL GUINEA",
                    @"ERITREA",
                    @"ESTONIA",
                    @"ETHIOPIA",
                    @"FALKLAND ISLANDS",
                    @"FAROE ISLANDS",
                    @"FIJI",
                    @"FINLAND",
                    @"FRANCE",
                    @"FRENCH POLYNESIA",
                    @"GABON",
                    @"GAMBIA",
                    @"GEORGIA",
                    @"GERMANY",
                    @"GHANA",
                    @"GIBRALTAR",
                    @"GREECE",
                    @"GREENLAND",
                    @"GRENADA",
                    @"GUAM",
                    @"GUATEMALA",
                    @"GUERNSEY",
                    @"GUINEA",
                    @"GUINEA-BISSAU",
                    @"GUYANA",
                    @"HAITI",
                    @"HONDURAS",
                    @"HONG KONG",
                    @"HUNGARY",
                    @"ICELAND",
                    @"INDIA",
                    @"INDONESIA",
                    @"IRAN",
                    @"IRAQ",
                    @"IRELAND",
                    @"ISLE OF MAN",
                    @"ISRAEL",
                    @"ITALY",
                    @"IVORY COAST",
                    @"JAMAICA",
                    @"JAPAN",
                    @"JERSEY",
                    @"JORDON",
                    @"KAZAKHSTAN",
                    @"KENYA",
                    @"KIRIBATI",
                    @"KOSOVO",
                    @"KUWAIT",
                    @"KYRGYZSTAN",
                    @"LAOS",
                    @"LATVIA",
                    @"LEBANON",
                    @"LESOTHO",
                    @"LIBERIA",
                    @"LIBYA",
                    @"LIECHTENSTEIN",
                    @"LITHUANIA",
                    @"LUXEMBOURG",
                    @"MACAO",
                    @"MACEDONIA",
                    @"MADAGASCAR",
                    @"MALAWI",
                    @"MALAYSIA",
                    @"MALDIVES",
                    @"MALI",
                    @"MALTA",
                    @"MARSHALL ISLANDS",
                    @"MAURITANIA",
                    @"MAURITIUS",
                    @"MAYOTTE",
                    @"MEXICO",
                    @"MICRONESIA",
                    @"MOLDOVA",
                    @"MONACO",
                    @"MONGOLIA",
                    @"MONTENEGRO",
                    @"MONTSERRAT",
                    @"MOROCCO",
                    @"MOZAMBIQUE",
                    @"MYANMAR",
                    @"NAMIBIA",
                    @"NAURU",
                    @"NEPAL",
                    @"NETHERLANDS",
                    @"NETHERLANDS ANTILLES",
                    @"NEW CALEDONIA",
                    @"NEW ZEALAND",
                    @"NICARAGUA",
                    @"NIGER",
                    @"NIGERIA",
                    @"NIUE",
                    @"NORTH KOREA",
                    @"NORTHERN MARIANA ISLANDS",
                    @"NORWAY",
                    @"OMAN",
                    @"PAKISTAN",
                    @"PALAU",
                    @"PALESTINE",
                    @"PANAMA",
                    @"PAPUA NEW GUINEA",
                    @"PARAGUAY",
                    @"PERU",
                    @"PHILIPPINES",
                    @"PITCAIRN",
                    @"POLAND",
                    @"PORTUGAL",
                    @"PUERTO RICO",
                    @"QATAR",
                    @"REPUBLIC OF THE CONGO",
                    @"REUNION",
                    @"ROMANIA",
                    @"RUSSIA",
                    @"RWANDA",
                    @"SAINT BARTHELEMY",
                    @"SAINT HELENA",
                    @"SAINT KITTS AND NEVIS",
                    @"SAINT LUCIA",
                    @"SAINT PIERRE AND MIQUELON",
                    @"SAINT VINCENT AND THE GRENADINES",
                    @"SAMOA",
                    @"SAN MARINO",
                    @"SAO TOME AND PRINCIPE",
                    @"SAUDI ARABIA",
                    @"SENEGAL",
                    @"SERBIA",
                    @"SEYCHELLES",
                    @"SIERRA LEONE",
                    @"SINGAPORE",
                    @"SINT MAARTEN",
                    @"SLOVAKIA",
                    @"SLOVENIA",
                    @"SOLOMON ISLANDS",
                    @"SOMALIA",
                    @"SOUTH AFRICA",
                    @"SOUTH KOREA",
                    @"SOUTH SUDAN",
                    @"SPAIN",
                    @"SRI LANKA",
                    @"SUDAN",
                    @"SURINAME",
                    @"SVALBARD AND JAN MAYEN",
                    @"SWAZILAND",
                    @"SWEDEN",
                    @"SWITZERLAND",
                    @"SYRA",
                    @"TAIWAN",
                    @"TAJIKISTAN",
                    @"TANZANIA",
                    @"THAILAND",
                    @"TOGO",
                    @"TOKELAU",
                    @"TONGA",
                    @"TRINIDAD AND TOBAGO",
                    @"TUNISIA",
                    @"TURKEY",
                    @"TURKMENISTAN",
                    @"TURKS AND CAICOS ISLANDS",
                    @"TUVALU",
                    @"US VIRGIN ISLANDS",
                    @"UGANDA",
                    @"UKRAINE",
                    @"UNITED ARAB EMIRATES",
                    @"UNITED KINGDOM",
                    @"URUGUAY",
                    @"UZBEKISTAN",
                    @"VANUATU",
                    @"VATICAN",
                    @"VENEZUELA",
                    @"VIETNAM",
                    @"WALLIS AND FUTUNA",
                    @"WESTERN SAHARA",
                    @"YEMEN",
                    @"ZAMBIA",
                    @"ZIMBABWE"];
    self.picker =[[UIPickerView alloc] initWithFrame:CGRectZero];
    self.numberTextField.delegate = self;
    [self attachPickerToTextField:self.countryTextField :self.picker];
    countrycode = @"+1";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)attachPickerToTextField: (UITextField*) textField:(UIPickerView*) picker{
    picker.delegate =self;
    picker.dataSource =self;
    textField.delegate = self;
    textField.inputView = picker;
}

#pragma mark - Keyboard delegate

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.countryTextField resignFirstResponder];
    [self.numberTextField resignFirstResponder];
    [self.verificationTextField resignFirstResponder];
}

#pragma mark - Picker delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView == self.picker){
        return self->pickerArray.count;
    }
    return 0;
}

-(NSString *)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
  {
      if(pickerView == self.picker){
          return[self->pickerArray objectAtIndex:row];
      }
      return @"???";
  }
    
-(void)pickerView:(UIPickerView*)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
  {
      
      if (pickerView == self.picker){
          if([[self->pickerArray objectAtIndex:row] isEqualToString: @"USA"])
             countrycode = @"+1";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"AFGHANISTAN"])
              countrycode = @"+93";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"ALBANIA"])
              countrycode = @"+355";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"ALGERIA"])
              countrycode = @"+213";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"AMERICAN SAMOA"])
              countrycode = @"+1-684";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"ANDORRA"])
              countrycode = @"+376";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"ANGOLA"])
              countrycode = @"+244 ";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"ANGUILLA"])
              countrycode = @"+1-264";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"ANTARCTICA"])
              countrycode = @"+672";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"ANTIGUA AND BARBUDA"])
              countrycode = @"+1-268";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"ARGENTINA"])
              countrycode = @"+54";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"ARMENIA"])
              countrycode = @"+374";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"ARUBA"])
              countrycode = @"+297";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"AUSTRALIA"])
              countrycode = @"+61";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"AUSTRIA"])
              countrycode = @"+43";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"AZERBAIJAN"])
              countrycode = @"+994";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"BAHAMAS"])
              countrycode = @"+1-242";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"BAHRAIN"])
              countrycode = @"+973";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"BANGLADESH"])
              countrycode = @"+880";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"BARBADOS"])
              countrycode = @"+1-246";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"BELARUS"])
              countrycode = @"+375";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"BELGUIM"])
              countrycode = @"+32";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"BELIZE"])
              countrycode = @"+501";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"BENIN"])
              countrycode = @"+229";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"BERMUDA"])
              countrycode = @"+1-441";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"BHUTAN"])
              countrycode = @"+975";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"BOLIVIA"])
              countrycode = @"+591";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"BOSNIA AND HERZEGOVINA"])
              countrycode = @"+387";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"BOTSWANA"])
              countrycode = @"+267";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"BRAZIL"])
              countrycode = @"+55";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"BRITISH INDIAN OCEAN TERRITORY"])
              countrycode = @"+246";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"BRITISH VIRGIN ISLANDS"])
              countrycode = @"+1-284";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"BRUNEI"])
              countrycode = @"+673";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"BULGARIA"])
              countrycode = @"+359";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"BURKINA FASO"])
              countrycode = @"+226";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"BURUNDI"])
              countrycode = @"+257";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"CAMBODIA"])
              countrycode = @"+855";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"CAMEROON"])
              countrycode = @"+237";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"CANADA"])
              countrycode = @"+1";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"CAPE VERDE"])
              countrycode = @"+238";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"CAYMAN ISLANDS"])
              countrycode = @"+1-345";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"CENTRAL AFRICAN REPUBLIC"])
              countrycode = @"+236";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"CHAD"])
              countrycode = @"+235";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"CHILE"])
              countrycode = @"+56";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"CHINA"])
              countrycode = @"+86";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"CHRISTMAS ISLAND"])
              countrycode = @"+61";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"COCOS ISLANDS"])
              countrycode = @"+61";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"COLOMBIA"])
              countrycode = @"+57";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"COMOROS"])
              countrycode = @"+269";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"COOK ISLANDS"])
              countrycode = @"+682";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"COSTA RICA"])
              countrycode = @"+506";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"CROATIA"])
              countrycode = @"+385";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"CUBA"])
              countrycode = @"+53";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"CURACAO"])
              countrycode = @"+599";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"CYPRUS"])
              countrycode = @"+357";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"CZECH REPUBLIC"])
              countrycode = @"+420";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"DEMOCRATIC REPUBLIC OF THE CONGO"])
              countrycode = @"+243";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"DENMARK"])
              countrycode = @"+45";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"DJIBOUTI"])
              countrycode = @"+253";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"DOMINICA"])
              countrycode = @"+1-767";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"DOMINICAN REPUBLIC"])
              countrycode = @"+1-809";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"EAST TIMOR"])
              countrycode = @"+670";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"ECUADOR"])
              countrycode = @"+593";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"EGPYT"])
              countrycode = @"+20";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"EL SALVADOR"])
              countrycode = @"+503";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"EQUATORIAL GUINEA"])
              countrycode = @"+240";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"ERITREA"])
              countrycode = @"+291";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"ESTONIA"])
              countrycode = @"+372";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"ETHIOPIA"])
              countrycode = @"+251";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"FALKLAND ISLANDS"])
              countrycode = @"+500";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"FAROE ISLANDS"])
              countrycode = @"+298";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"FIJI"])
              countrycode = @"+679";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"FINLAND"])
              countrycode = @"+358";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"FRANCE"])
              countrycode = @"+33";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"FRENCH POLYNESIA"])
              countrycode = @"+689";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"GABON"])
              countrycode = @"+241";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"GAMBIA"])
              countrycode = @"+220";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"GEORGIA"])
              countrycode = @"+995";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"GERMANY"])
              countrycode = @"+49";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"GHANA"])
              countrycode = @"+233";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"GIBRALTAR"])
              countrycode = @"+350";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"GREECE"])
              countrycode = @"+30";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"GREENLAND"])
              countrycode = @"+299";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"GRENADA"])
              countrycode = @"+1-473";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"GUAM"])
              countrycode = @"+1-671";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"GUATEMALA"])
              countrycode = @"+502";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"GUERNSEY"])
              countrycode = @"+44-1481";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"GUINEA"])
              countrycode = @"+224";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"GUINEA-BISSAU"])
              countrycode = @"+245";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"GUYANA"])
              countrycode = @"+592";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"HAITI"])
              countrycode = @"+509";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"HONDURAS"])
              countrycode = @"+504";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"HONG KONG"])
              countrycode = @"+852";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"HUNGARY"])
              countrycode = @"+36";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"ICELAND"])
              countrycode = @"+354";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"INDIA"])
              countrycode = @"+91";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"INDONESIA"])
              countrycode = @"+62";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"IRAN"])
              countrycode = @"+98";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"IRAQ"])
              countrycode = @"+964";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"IRELAND"])
              countrycode = @"+353";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"ISLE OF MAN"])
              countrycode = @"+44-1624";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"ISRAEL"])
              countrycode = @"+972";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"ITALY"])
              countrycode = @"+39";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"IVORY COAST"])
              countrycode = @"+225";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"JAMAICA"])
              countrycode = @"+1-876";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"JAPAN"])
              countrycode = @"81";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"JERSEY"])
              countrycode = @"+44-1534";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"JORDAN"])
              countrycode = @"+962";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"KAZAKHSTAN"])
              countrycode = @"+7";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"KENYA"])
              countrycode = @"+254";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"KIRIBATI"])
              countrycode = @"+686";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"KOSOVO"])
              countrycode = @"+383";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"KUWAIT"])
              countrycode = @"+965";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"KYRGYZSTAN"])
              countrycode = @"+996";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"LAOS"])
              countrycode = @"+856";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"LATVIA"])
              countrycode = @"+371";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"LEBANON"])
              countrycode = @"+961 ";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"LESOTHO"])
              countrycode = @"+266";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"LIBERIA"])
              countrycode = @"+231";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"LIBYA"])
              countrycode = @"+218";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"LIECHTENSTEIN"])
              countrycode = @"+423";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"LITHUANIA"])
              countrycode = @"+370";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"LUXEMBOURG"])
              countrycode = @"+352";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"MACAO"])
              countrycode = @"+853";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"MACEDONIA"])
              countrycode = @"+389";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"MADAGASCAAR"])
              countrycode = @"+261";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"MALAWI"])
              countrycode = @"+265";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"MALAYSIA"])
              countrycode = @"+60";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"MALDIVES"])
              countrycode = @"+960";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"MALI"])
              countrycode = @"+223";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"MALTA"])
              countrycode = @"+356";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"MARSHALL ISLANDS"])
              countrycode = @"+692";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"MAURITANIA"])
              countrycode = @"+222";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"MAURITIUS"])
              countrycode = @"+230";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"MAYOTTE"])
              countrycode = @"+262";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"MEXICO"])
              countrycode = @"+52";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"MICRONESIA"])
              countrycode = @"+691";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"MOLDOVA"])
              countrycode = @"+373";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"MONACO"])
              countrycode = @"+377";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"MONGOLIA"])
              countrycode = @"+976";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"MONTENEGRO"])
              countrycode = @"+382";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"MONTSERRAT"])
              countrycode = @"+1-664";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"MOROCCO"])
              countrycode = @"+212";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"MOZAMBIQUE"])
              countrycode = @"+258";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"MYANMAR"])
              countrycode = @"+95";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"NAMIBIA"])
              countrycode = @"+264";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"NAURU"])
              countrycode = @"+674";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"NEPAL"])
              countrycode = @"+977";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"NETHERLANDS"])
              countrycode = @"+31";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"NETHERLANDS ANTILLES"])
              countrycode = @"+599";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"NEW CALEDONIA"])
              countrycode = @"+687";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"NEW ZEALAND"])
              countrycode = @"+64";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"NICARAGUA"])
              countrycode = @"+505";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"NIGER"])
              countrycode = @"+227";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"NIGERIA"])
              countrycode = @"+234";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"NIUE"])
              countrycode = @"+683";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"NORTH KOREA"])
              countrycode = @"+850";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"NORTHERN MARIANA ISLANDS"])
              countrycode = @"+1-670";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"NORWAY"])
              countrycode = @"+47";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"OMAN"])
              countrycode = @"+968";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"PAKISTAN"])
              countrycode = @"+92";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"PALAU"])
              countrycode = @"+680";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"PALESTINE"])
              countrycode = @"+970";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"PANAMA"])
              countrycode = @"+507";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"PAPUA NEW GUINEA"])
              countrycode = @"+675";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"PARAGUAY"])
              countrycode = @"+595";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"PERU"])
              countrycode = @"+51";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"PHILIPPINES"])
              countrycode = @"+63";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"PITCAIRN"])
              countrycode = @"+64";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"POLAND"])
              countrycode = @"+48";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"PORTUGAL"])
              countrycode = @"+351";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"PUERTO RICO"])
              countrycode = @"+1-787";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"QATAR"])
              countrycode = @"+974";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"REPUBLIC OF THE CONGO"])
              countrycode = @"+242";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"REUNION"])
              countrycode = @"+262";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"ROMANIA"])
              countrycode = @"+40";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"RUSSIA"])
              countrycode = @"+7";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"RWANDA"])
              countrycode = @"+250";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SAINT BARTHELEMY"])
              countrycode = @"+590";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SAINT HELENA"])
              countrycode = @"+290";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SAINT KITTS AND NEVIS"])
              countrycode = @"+1-869";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SAINT LUCIA"])
              countrycode = @"+1-758";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SAINT MARTIN"])
              countrycode = @"+590";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SAINT PIERRE AND MIQUELON"])
              countrycode = @"+508";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SAINT VINCENT AND GRENADINES"])
              countrycode = @"+1-784";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SAMOA"])
              countrycode = @"+685";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SAN MARINO"])
              countrycode = @"+378";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SAO TOME AND PRINCIPE"])
              countrycode = @"+239";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SAUDI ARABIA"])
              countrycode = @"+966";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SENEGAL"])
              countrycode = @"+221";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SERBIA"])
              countrycode = @"+381";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SEYCHELLES"])
              countrycode = @"+248";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SIERRA LEONE"])
              countrycode = @"+232";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SINGAPORE"])
              countrycode = @"+65";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SINT MAARTEN"])
              countrycode = @"+1-721";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SLOVAKIA"])
              countrycode = @"+421";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SLOVENIA"])
              countrycode = @"+386";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SOLOMON ISLANDS"])
              countrycode = @"+677";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SOMALIA"])
              countrycode = @"+252";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SOUTH AFRICA"])
              countrycode = @"+27";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SOUTH KOREA"])
              countrycode = @"+82";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SOUTH SUDAN"])
              countrycode = @"+211";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SPAIN"])
              countrycode = @"+34";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SRI LANKA"])
              countrycode = @"+94";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SUDAN"])
              countrycode = @"+249";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SURINAME"])
              countrycode = @"+597";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SVALBARD AND JAN MAYEN"])
              countrycode = @"+47";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SWAZILAND"])
              countrycode = @"+268";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SWEDEN"])
              countrycode = @"+46";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SWITZERLAND"])
              countrycode = @"+41";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"SYRIA"])
              countrycode = @"+963";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"TAIWAN"])
              countrycode = @"+886";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"TAJIKISTAN"])
              countrycode = @"+992";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"TANZANIA"])
              countrycode = @"+255";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"THAILAND"])
              countrycode = @"+66";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"TOGO"])
              countrycode = @"+228";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"TOKELAU"])
              countrycode = @"+690";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"TONGA"])
              countrycode = @"+676";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"TRINIDAD AND TOBAGO"])
              countrycode = @"+1-868";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"TUNISIA"])
              countrycode = @"+216";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"TURKEY"])
              countrycode = @"+90";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"TURKMENISTAN"])
              countrycode = @"+993";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"TURKS AND CAICOS ISLANDS"])
              countrycode = @"+1-649";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"TUVALU"])
              countrycode = @"+688";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"US VIRGIN ISLANDS"])
              countrycode = @"+1-340";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"UGANDA"])
              countrycode = @"+256";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"UKRAINE"])
              countrycode = @"+380";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"UNITED ARAB EMIRATES"])
              countrycode = @"+971";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"UNITED KINGDOM"])
              countrycode = @"44";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"URUGUAY"])
              countrycode = @"+598";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"UZBEKISTAN"])
              countrycode = @"+998";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"VANUATU"])
              countrycode = @"+678";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"VATICAN"])
              countrycode = @"+379";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"VENEZUELA"])
              countrycode = @"+58";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"VIETNAM"])
              countrycode = @"+84";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"WALLIS AND FUTUNA"])
              countrycode = @"+681";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"WESTERN SAHARA"])
              countrycode = @"+212";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"YEMEN"])
              countrycode = @"+967";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"ZAMBIA"])
              countrycode = @"+260";
          else if([[self->pickerArray objectAtIndex:row] isEqualToString: @"ZIMBABWE"])
              countrycode = @"+263";
          
          self.countryTextField.text = countrycode/*[self->pickerArray objectAtIndex:row]*/;
      } // end if statement
      
      
  }

#pragma mark - number formatter

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(textField.tag ==2){
        NSInteger length = [self getLength:textField.text];
        //NSLog(@"Length  =  %d ",length);
        
        if(length == 10)
        {
            if(range.length == 0)
                return NO;
        }
        
        if(length == 3)
        {
            NSString *num = [self formatNumber:textField.text];
            textField.text = [NSString stringWithFormat:@"(%@) ",num];
            if(range.length > 0)
                textField.text = [NSString stringWithFormat:@"%@",[num substringToIndex:3]];
        }
        else if(length == 6)
        {
            NSString *num = [self formatNumber:textField.text];
            //NSLog(@"%@",[num  substringToIndex:3]);
            //NSLog(@"%@",[num substringFromIndex:3]);
            textField.text = [NSString stringWithFormat:@"(%@) %@-",[num  substringToIndex:3],[num substringFromIndex:3]];
            if(range.length > 0)
                textField.text = [NSString stringWithFormat:@"(%@) %@",[num substringToIndex:3],[num substringFromIndex:3]];
        }
    }
    return YES;
    
    
}

-(NSString*)formatNumber:(NSString*)mobileNumber
{
    
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
  
    
    NSInteger length = [mobileNumber length];
    if(length > 10)
    {
        mobileNumber = [mobileNumber substringFromIndex: length-10];
        
    }
    
    
    return mobileNumber;
}

-(NSInteger)getLength:(NSString*)mobileNumber
{
    
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    NSInteger length = [mobileNumber length];
    
    return length;
    
    
}

#pragma mark - Button actions

- (IBAction)LogIn:(id)sender {
    [self.countryTextField resignFirstResponder];
    [self.numberTextField resignFirstResponder];
    NSString *number = [self.numberTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *usertext = [self formatNumber: number];
    NSString *password = @"password";

    if ([number length] != 14) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                            message:@"You have to enter a number                                             e.g. (702) 123-4567"
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else {

        
 // begin query process
        PFQuery *query = [PFUser query];
        [query whereKey:@"username" equalTo:usertext];
        PFObject *user = [query getFirstObject];
        

        // if user exists
        if ([user objectForKey:@"username"] != nil) {
            [PFUser logOut];
                    [PFUser logInWithUsernameInBackground:usertext password:password block:^(PFUser *user, NSError *error) {
                        if (error) {
                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                                                message:[error.userInfo objectForKey:@"error"]
                                                                               delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                            [alertView show];   
                        }
                        else {
                            //begin to see if it has been verified already
          [self.navigationController popToRootViewControllerAnimated:YES];
                        }
                    }];
        }
    
        //if user does not exist
        else{

            //create anonymous user
            [PFAnonymousUtils logInWithBlock:^(PFUser *user, NSError *error) {
                if (error) {
                    NSLog(@"Anonymous login failed.");
                } else {
                    NSLog(@"Anonymous user logged in.");
                    NSDictionary *params = [NSDictionary dictionaryWithObject:usertext forKey:@"phoneNumber"];
                    [PFCloud callFunctionInBackground:@"sendVerificationCode" withParameters:params block:^(id object, NSError *error) {
                        NSString *message = @"Message Sent!";
                        if (!error) {
                            
                            _registernum.hidden = YES;
                            _loginnum.hidden = YES;
                            _numberTextField.hidden = YES;
                            _countryTextField.hidden = YES;
                            _verificationTextField.hidden = NO;
                            _backButton.hidden = NO;
                            _entercode.hidden = NO;
                            
                        } else {
                            message = @"There was an error!";
                        }
                        
                        [[[UIAlertView alloc] initWithTitle:@""
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil, nil] show];
                        
                    }];
                    

                }
            }];


 
          

        }
    }
    

}

- (IBAction)enterCode:(id)sender {
    NSString *number = [self.numberTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *usertext = [self formatNumber: number];

NSString *code = [self.verificationTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
NSDictionary *params = [NSDictionary dictionaryWithObject:code forKey:@"phoneVerificationCode"];
    
    
    
    [PFCloud callFunctionInBackground:@"verifyPhoneNumber" withParameters:params block:^(id object, NSError *error) {
        NSString *message = @"You are verified";
        if (!error) {
            [PFUser logOut];
            PFUser *newUser = [PFUser user];
            newUser.username = usertext;
            newUser.password = @"password";
            newUser[@"countrycode"] = countrycode;
            
            [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                                        message:[error.userInfo objectForKey:@"error"]
                                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alertView show];
                    
                }
                else {
                    
                }
            }];
                                 [self.navigationController popToRootViewControllerAnimated:YES];
       
        } else {
           message = @"Incorrect Verification Code";
        }
        
        [[[UIAlertView alloc] initWithTitle:@" "
                                    message:message
                                   delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil, nil] show];
        
    }];

    
}

- (IBAction)backButton:(id)sender {
    _backButton.hidden = YES;
    _registernum.hidden = NO;
    _loginnum.hidden = NO;
    _verificationTextField.hidden = YES;
    _numberTextField.hidden = NO;
    _countryTextField.hidden = NO;
    _entercode.hidden = YES;
}

@end
