import { Body, Controller, Get, HttpCode, HttpStatus, Post, Patch, Param, Delete } from '@nestjs/common';
import { CreateBrandDto, UpdateBrandDto } from './brand.dto';
import { BrandService } from './brand.service';

@Controller('brand')
export class BrandController {
  constructor(private brandService: BrandService) {}

  @Get()
  @HttpCode(HttpStatus.OK)
  async getAllBrands() {
    return await this.brandService.getAllBrands();
  }

  @Post()
  @HttpCode(HttpStatus.CREATED)
  async creatBrand(@Body() createBrandDto: CreateBrandDto) {
    return await this.brandService.createBrand(createBrandDto);
  }

  @Patch('/:id')
  @HttpCode(HttpStatus.OK)
  async updateBrandById(
    @Param('id') id: string,
    @Body() updateBrandDto: UpdateBrandDto
  ) {
    return await this.brandService.updateBrandById(
      parseInt(id),
      updateBrandDto
    );
  }

  @Delete('/:id')
  @HttpCode(HttpStatus.OK)
  async deleteBrandById(@Param('id') id: string) {
    return await this.brandService.deleteBrandById(parseInt(id));
  }
}
