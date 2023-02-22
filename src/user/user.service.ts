import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateUserDto } from './user.dto';
import { users } from '@prisma/client';

@Injectable()
export class UserService {
    constructor(private prisma: PrismaService) { }

    async findUserByUsername(username: string) {
        return await this.prisma.users.findUnique({
            where: { username: username },
        });
    }

    async findUserByEmail(email: string) {
        return await this.prisma.users.findUnique({
            where: { email: email },
        });
    }

    async createUser(createUserDto: CreateUserDto) {
        const existUser: users[] = await this.prisma
            .$queryRaw`SELECT * FROM users WHERE username = ${createUserDto.username} OR email= ${createUserDto.email}`;

        if (existUser.length > 0) {
            throw new HttpException(
                { message: 'User already exist' },
                HttpStatus.BAD_REQUEST,
            );
        }

        return await this.prisma.users.create({ data: { ...createUserDto } });
    }

    async getAllUsers() {
        return await this.prisma.users.findMany({ where: { is_admin: false } })
    }

    async deleteUserById(id: number) {
        await this.prisma.users
            .delete({ where: { id: id, } })
            .catch((err) => {
                throw new HttpException({ message: err }, HttpStatus.BAD_REQUEST);
            });

        return { message: 'Delete user success' };
    }
}
