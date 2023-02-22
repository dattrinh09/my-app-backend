import {
    Body,
    Controller,
    Delete,
    Get,
    HttpCode,
    Param,
    Patch,
    Post,
    Query,
    UseGuards,
} from '@nestjs/common';
import { ProductService } from './product.service';
import { JwtAuthGuard } from '../auth/guard/jwt.guard';
import { UpdateProductDto, CreateProductDto } from './product.dto';
import { HttpStatus } from '@nestjs/common';

@Controller('product')
export class ProductController {
    constructor(private productService: ProductService) { }

    @Post()
    @HttpCode(HttpStatus.CREATED)
    //@UseGuards(JwtAuthGuard)
    async createProduct(@Body() createProductDto: CreateProductDto) {
        return await this.productService.createProduct(createProductDto);
    }

    @Get()
    @HttpCode(HttpStatus.OK)
    //@UseGuards(JwtAuthGuard)
    async getAllProducts() {
        return this.productService.getAllProducts();
    }

    @Get('/{id}')
    @HttpCode(HttpStatus.OK)
    // @UseGuards(JwtAuthGuard)
    async getProductById(@Param('id') id: string) {
        return this.productService.getProductById(parseInt(id));
    }

    @Get('/name/:product_name')
    @HttpCode(HttpStatus.OK)
    async getProductByName(@Param('product_name') product_name: string) {
        return this.productService.getProductByName(product_name);
    }

    @Patch('/:id')
    @HttpCode(HttpStatus.OK)
    //@UseGuards(JwtAuthGuard)
    async updateProductById(
        @Param('id') id: string,
        @Body() updateProductDto: UpdateProductDto,
    ) {
        return await this.productService.updateProductById(
            parseInt(id),
            updateProductDto,
        );
    }

    @Delete('/:id')
    @HttpCode(HttpStatus.OK)
    //@UseGuards(JwtAuthGuard)
    async deleteProductById(@Param('id') id: string) {
        return await this.productService.deleteProductById(parseInt(id));
    }

    @Get('/page')
    async getAllProductsWithFilterAndPagination(
        @Query('page') page: string,
        @Query('per_page') perPage: string,
        @Query('low') low: string,
        @Query('high') high: string,
        @Query('brand_name') brandName: string,
    ) {
        return await this.productService.getAllProductsWithFilterAndPagination(
            parseInt(page),
            parseInt(perPage),
            parseInt(low),
            parseInt(high),
            brandName,
        );
    }

    @Get('/search')
    async getAllProductsWithKeyword(
        @Query('page') page: string,
        @Query('per_page') perPage: string,
        @Query('keyword') keyword: string,
    ) {
        return await this.productService.getAllProductsWithKeyword(
            parseInt(page),
            parseInt(perPage),
            keyword,
        );
    }
}
