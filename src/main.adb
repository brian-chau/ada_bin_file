with Ada.Streams.Stream_Io;
with Ada.Sequential_IO;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Conversion;
with Gnat.Os_Lib;
with Interfaces; use Interfaces;
with System;

procedure Main is
   type Bit          is mod (2 ** 1);
   type TwoBit       is mod (2 ** 2);
   type FourBit      is mod (2 ** 4);
   type SevenBit     is mod (2 ** 7);
   type EightBit     is mod (2 ** 8);
   type NineBit      is mod (2 ** 9);
   type SixteenBit   is mod (2 ** 16);
   type SixtyFourBit is mod (2 ** 64);

   type Cab_Rec is
      record
         tpep_pickup_datetime  : SixtyFourBit;
         tpep_dropoff_datetime : SixtyFourBit;
         passenger_count       : FourBit;
         vendor_id             : Bit;
         store_and_forward     : Bit;
         payment_type          : TwoBit;
         spare1                : EightBit;
         pu_location_id        : NineBit;
         rate_code_id          : SevenBit;
         do_location_id        : NineBit;
         spare2                : SevenBit;
         trip_distance         : SixteenBit;
      end record;

   pragma Pack (Cab_Rec);

   package TaxiRec_IO is new Ada.Sequential_IO(Cab_Rec);
   use TaxiRec_IO;

   The_File   : TaxiRec_IO.File_Type;
   A_Rec      : Cab_Rec;

   PUCount    : Integer := 0;
   DOCount    : Integer := 0;

   -- BJC: Debugging, used to check the size of the record
   -- Size       : Integer := 0;
begin
   begin
      Open (The_File, In_File, "out.bin");
   exception
      when others =>
         GNAT.OS_Lib.OS_Exit (0);
         -- Create (The_File, Out_File, "test.dat"); -- Reference for later
   end;


   while not End_Of_File ( The_File ) loop
      Read ( The_File, A_Rec );
      if A_Rec.payment_type = 3 then
         if A_Rec.pu_location_id = 170 then
            PUCount := PUCount + 1;
         elsif A_Rec.do_location_id = 170 then
            DOCount := DOCount + 1;
         end if;
      end if;
   end loop;

   Put_Line(Integer'Image(PUCount));
   Put_Line(Integer'Image(DOCount));

   -- Size := Cab_Rec'Size;
   -- Put(Integer'Image(Size));
   Close (The_File);
end Main;
