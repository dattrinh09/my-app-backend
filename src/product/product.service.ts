import { Injectable, HttpException, HttpStatus } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { UpdateProductDto, CreateProductDto } from './product.dto';

@Injectable()
export class ProductService {
    constructor(private prisma: PrismaService) { }

    async createProduct(createProductDto: CreateProductDto) {
        const existBrand = await this.prisma.brands.findUnique({
            where: { brand_name: createProductDto.brand_name },
        });
        if (!existBrand) {
            throw new HttpException(
                { message: 'brand not found' },
                HttpStatus.BAD_REQUEST,
            );
        }

        const product = await this.prisma.products.findFirst({
            where: {
                brand_id: existBrand.id,
                product_name: createProductDto.product_name,
            },
        });
        if (product) {
            throw new HttpException(
                { message: 'product already exist' },
                HttpStatus.BAD_REQUEST,
            );
        }

        return await this.prisma.products.create({
            data: {
                product_name: createProductDto.product_name,
                description: createProductDto.description,
                price: createProductDto.price,
                in_stock: createProductDto.in_stock,
                brand_id: existBrand.id,
                url: createProductDto.url,
            },
            select: {
                id: true,
                product_name: true,
                description: true,
                brand: true,
                price: true,
                in_stock: true,
            },
        });
    }

    async getAllProducts() {
        const products = await this.prisma.products.findMany({
            select: {
                id: true,
                product_name: true,
                brand: true,
                price: true,
                in_stock: true,
                description: true,
                url: true,
            },
            orderBy: {
                id: 'asc',
            },
        });

        return {
            total: products.length,
            products: products,
        };
    }

    async getProductByName(product_name: string) {
        return await this.prisma.products.findFirst({
            select: {
                id: true,
                product_name: true,
                brand: true,
                price: true,
                in_stock: true,
                description: true,
                url: true,
            },
            where: {
                product_name: product_name,
            }
        })
    }

    async getAllProductsWithFilterAndPagination(
        page: number,
        perPage: number,
        low: number,
        high: number,
        brandName: string,
    ) {
        if (brandName !== undefined) {
            const brand = await this.prisma.brands.findFirst({
                where: {
                    brand_name: brandName,
                },
            });

            const total = await this.prisma.products.count({
                where: {
                    price: {
                        gte: low ? low * 1000000 : 0,
                        lte: high ? high * 1000000 : 1000000000 * 1000000000,
                    },
                    brand_id: brand.id,
                },
            });

            const products = await this.prisma.products.findMany({
                select: {
                    id: true,
                    product_name: true,
                    brand: true,
                    brand_id: true,
                    price: true,
                    in_stock: true,
                    description: true,
                    url: true,
                },
                where: {
                    price: {
                        gte: low ? low * 1000000 : 0,
                        lte: high ? high * 1000000 : 1000000000 * 1000000000,
                    },
                    brand_id: brand.id,
                },
                skip: (page - 1) * perPage,
                take: perPage,
            });

            return {
                total: total,
                products: products,
            };
        }
        const products = await this.prisma.products.findMany({
            select: {
                id: true,
                product_name: true,
                brand: true,
                brand_id: true,
                price: true,
                in_stock: true,
                description: true,
                url: true,
            },
            where: {
                price: {
                    gte: low ? low * 1000000 : 0,
                    lte: high ? high * 1000000 : 1000000000 * 1000000000,
                },
            },
            skip: (page - 1) * perPage,
            take: perPage,
        });

        const total = await this.prisma.products.count({
            where: {
                price: {
                    gte: low ? low * 1000000 : 0,
                    lte: high ? high * 1000000 : 1000000000 * 1000000000,
                },
            },
        });

        return {
            total: total,
            products: products,
        };
    }

    async getAllProductsWithKeyword(
        page: number,
        perPage: number,
        keyword: string,
    ) {
        const total = await this.prisma.products.count({
            where: {
                product_name: {
                    contains: keyword ? keyword : '',
                    mode: 'insensitive',
                },
            },
        })
        const products = await this.prisma.products.findMany({
            select: {
                id: true,
                product_name: true,
                brand: true,
                price: true,
                in_stock: true,
                description: true,
                url: true,
            },
            where: {
                product_name: {
                    contains: keyword ? keyword : '',
                    mode: 'insensitive',
                },
            },
            skip: (page - 1) * perPage,
            take: perPage,
        });

        return {
            products: products,
            total: total,
        };
    }

    async getProductById(productId: number) {
        const product = await this.prisma.products.findUnique({
            where: {
                id: productId,
            },
            select: {
                id: true,
                product_name: true,
                brand: true,
                price: true,
                in_stock: true,
                description: true,
                url: true,
            },
        });
        if (!product) {
            throw new HttpException(
                { message: 'product not found' },
                HttpStatus.BAD_REQUEST,
            );
        }

        return product;
    }

    async updateProductById(
        productId: number,
        productUpdateDto: UpdateProductDto,
    ) {
        return await this.prisma.products
            .update({
                where: { id: productId },
                data: {
                    product_name: productUpdateDto.product_name,
                    description: productUpdateDto.description,
                    in_stock: productUpdateDto.in_stock,
                    price: productUpdateDto.price,
                    url: productUpdateDto.url,
                },
                select: {
                    id: true,
                    product_name: true,
                    brand: true,
                    price: true,
                    in_stock: true,
                    description: true,
                    url: true,
                },
            })
            .catch((err) => {
                throw new HttpException({ message: err }, HttpStatus.BAD_REQUEST);
            });
    }

    async deleteProductById(productId: number) {
        await this.prisma.products
            .delete({
                where: { id: productId },
            })
            .catch((err) => {
                throw new HttpException({ message: err }, HttpStatus.BAD_REQUEST);
            });

        return { message: 'Delete product success' };
    }
}
