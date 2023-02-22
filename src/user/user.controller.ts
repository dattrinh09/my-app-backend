import { Controller, Get, HttpCode, HttpStatus } from "@nestjs/common";
import { Delete, Param } from "@nestjs/common/decorators";
import { UserService } from "./user.service";

@Controller('user')
export class UserController {
    constructor(private userService: UserService) { }

    @Get()
    @HttpCode(HttpStatus.OK)
    async getAllUsers() {
        return await this.userService.getAllUsers();
    }

    @Delete('/:id')
    @HttpCode(HttpStatus.OK)
    async deleteUserById(@Param('id') id: string) {
        return await this.userService.deleteUserById(parseInt(id))
    }
}