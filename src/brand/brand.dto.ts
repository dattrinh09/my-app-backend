import { IsNotEmpty, IsString } from 'class-validator';

export class CreateBrandDto {
    @IsNotEmpty()
    @IsString()
    brand_name: string;
}

export class UpdateBrandDto {
    @IsNotEmpty()
    @IsString()
    brand_name: string;
}
