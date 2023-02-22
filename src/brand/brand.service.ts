import { Injectable, HttpException, HttpStatus } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateBrandDto, UpdateBrandDto } from './brand.dto';

@Injectable()
export class BrandService {
  constructor(private prisma: PrismaService) {}

  async getAllBrands() {
    return await this.prisma.brands.findMany({
      orderBy: {
        id: "asc",
      }
    });
  }

  async getBrandByConditions(conditions: any) {
    return await this.prisma
      .$queryRaw`SELECT * FROM brands WHERE (id = ${conditions} OR brand_name = ${conditions})`;
  }

  async createBrand(createBrandDto: CreateBrandDto) {
    const brand = await this.prisma.brands.findUnique({
      where: {
        brand_name: createBrandDto.brand_name,
      },
    });

    if (brand) {
      throw new HttpException(
        { message: 'brand already exists' },
        HttpStatus.BAD_REQUEST,
      );
    }

    return await this.prisma.brands.create({
      data: {
        brand_name: createBrandDto.brand_name,
      },
    });
  }

  async updateBrandById(brandId: number, updateBrandDto: UpdateBrandDto) {
    return await this.prisma.brands
      .update({
        where: { id: brandId },
        data: { ...updateBrandDto },
      })
      .catch((err) => {
        throw new HttpException({ message: err }, HttpStatus.BAD_REQUEST);
      });
  }

  async deleteBrandById(brandId: number) {
    await this.prisma.brands
      .delete({
        where: { id: brandId },
      })
      .catch((err) => {
        throw new HttpException({ message: err }, HttpStatus.BAD_REQUEST);
      });

    return { message: 'Delete brand success' };
  }
}
