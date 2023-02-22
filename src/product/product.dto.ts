import { IsNumber, IsOptional, IsString, IsNotEmpty } from 'class-validator';

export class UpdateProductDto {
    @IsOptional()
    @IsString()
    product_name: string;

    @IsOptional()
    @IsString()
    description: string;

    @IsOptional()
    @IsNumber()
    price: number;

    @IsOptional()
    @IsNumber()
    in_stock: number;

    @IsOptional()
    @IsNotEmpty()
    url: string;
}

export class CreateProductDto {
    @IsNotEmpty()
    @IsString()
    product_name: string;

    @IsNotEmpty()
    @IsString()
    description: string;

    @IsNotEmpty()
    @IsNumber()
    price: number;

    @IsNotEmpty()
    @IsNumber()
    in_stock: number;

    @IsNotEmpty()
    @IsString()
    brand_name: string;

    @IsNotEmpty()
    @IsString()
    url: string;
}
