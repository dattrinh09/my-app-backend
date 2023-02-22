import {
    Body,
    Controller,
    Delete,
    Get,
    Param,
    Patch,
    Post,
} from '@nestjs/common';
import { OrderService } from './order.service';
import { CreateOrderDto, UpdateOrderDto } from './order.dto';

@Controller('order')
export class OrderController {
    constructor(private orderService: OrderService) { }

    @Get()
    async getAllOrders() {
        return this.orderService.getAllOrders();
    }

    @Get('/:id')
    async getOrderById(@Param('id') id: string) {
        return await this.orderService.getOrderById(parseInt(id));
    }

    @Get('/user/:user_id')
    async getOrdersByUserID(@Param('user_id') user_id: string) {
        return await this.orderService.getOrdersByUserID(parseInt(user_id));
    }

    @Post()
    async createOrder(@Body() body: CreateOrderDto) {
        return await this.orderService.createOrder(body);
    }

    @Patch('/:id')
    async updateOrder(
        @Param('id') id: string,
        @Body() updateOrderDto: UpdateOrderDto,
    ) {
        return await this.orderService.updateOrder(parseInt(id), updateOrderDto);
    }

    @Delete('/:id')
    async deleteOrder(@Param('id') id: string) {
        return await this.orderService.deleteOrder(parseInt(id));
    }
}
