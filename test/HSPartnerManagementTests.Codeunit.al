namespace HS.Tests;

using HS;
using System.TestLibraries.Utilities;
codeunit 70201 "HS Partner Management Tests"
{
    SubType = Test;

    var
        Partner: Record "HS Supplier";
        PartnerMgt: Codeunit "HS Supplier Mgt.";

    [Test]
    procedure TestAddressParsing()
    var
        Address: Text[100];
        HomeNo: Integer;
    begin
        Address := 'Main Street 45';
        HomeNo := PartnerMgt.CheckAndFormatAddress(Address);

        Assert.AreEqual(45, HomeNo, 'Home number parsing failed.');
        Assert.AreEqual('Main Street', Address, 'Address string was not cleaned correctly.');
    end;

    [Test]
    [HandlerFunctions('TestConfirmHandler')]
    procedure TestGenerateEmail()
    var
        Email: Text;
    begin
        Email := PartnerMgt.GenerateSupplierEMail('John Doe', 'BlueCorp');

        Assert.AreEqual('john.doe@bluecorp.com', Email, 'Email generation failed.');
    end;

    [ConfirmHandler]
    procedure TestConfirmHandler(Question: Text[1024]; var Reply: Boolean)
    begin
        Reply := true;
    end;

    [Test]
    procedure TestCheckSupplierBlocked()
    begin
        Partner.Init();
        Partner.Code := 'SUP001';
        Partner.Name := 'Test Partner';
        Partner.Blocked := true;
        Partner.Insert();

        asserterror PartnerMgt.CheckItemSupplierBlocked(Partner);

        Assert.ExpectedError('Supplier is Blocked.');
    end;

    [Test]
    procedure TestDuplicateSupplier()
    var
        NewPartner: Record "HS Supplier";
    begin
        Partner.Init();
        Partner.Code := 'SUP001';
        Partner.Name := 'Test Partner';
        Partner."Company Name" := 'TestCo';
        Partner.Insert();

        PartnerMgt.CreateNewSupplier(Partner);

        NewPartner.SetRange(Name, 'Test Partner');
        Assert.IsTrue(NewPartner.FindLast(), 'Duplicate supplier was not created.');
        Assert.AreEqual('', NewPartner."E-Mail", 'Email should be cleared.');
        Assert.AreEqual('', NewPartner."Contact No.", 'Contact No. should be cleared.');
    end;


    var
        Assert: Codeunit "Library Assert";
}
