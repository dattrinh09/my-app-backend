import { IsNumber, IsString, IsNotEmpty } from 'class-validator';

export class UpdateOrderDto {
    @IsNotEmpty()
    @IsNumber()
    status: number;
}

export class CreateOrderDto {
    @IsNotEmpty()
    @IsNumber()
    user_id: number;

    @IsNotEmpty()
    @IsNumber()
    product_id: number;

    @IsNotEmpty()
    @IsString()
    phone_number: string;

    @IsNotEmpty()
    @IsString()
    address: string;
}
