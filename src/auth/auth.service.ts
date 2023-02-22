import { Injectable, HttpException, HttpStatus } from '@nestjs/common';
import { UserService } from '../user/user.service';
import { JwtService } from '@nestjs/jwt';
import { CreateUserDto } from '../user/user.dto';
import { compare, hash } from 'bcrypt';
import { users } from '@prisma/client';
import { SignInDto } from './auth.dto';

@Injectable()
export class AuthService {
    constructor(
        private userService: UserService,
        private jwtService: JwtService,
    ) { }

    async signUp(createUserDto: CreateUserDto) {
        createUserDto.password = await hash(createUserDto.password, 10);
        try {
            const user = await this.userService.createUser(createUserDto);
            return this.generateJwt(user);
        } catch (error) {
            throw new HttpException(
                { message: error },
                HttpStatus.INTERNAL_SERVER_ERROR,
            );
        }
    }

    async signIn(signInDto: SignInDto) {
        const user = await this.userService.findUserByEmail(signInDto.email);
        if (!user) {
            throw new HttpException(
                { message: 'User not found' },
                HttpStatus.BAD_REQUEST,
            );
        }

        const comparePassword = await compare(signInDto.password, user.password);
        if (!comparePassword) {
            throw new HttpException(
                { message: 'Password is incorrect' },
                HttpStatus.BAD_REQUEST,
            );
        }

        return this.generateJwt(user);
    }

    async adminSignIn(signInDto: SignInDto) {
        const user = await this.userService.findUserByEmail(signInDto.email);
        if (!user) {
            throw new HttpException(
                { message: 'User not found' },
                HttpStatus.BAD_REQUEST,
            );
        }

        if (!user.is_admin) {
            throw new HttpException(
                { message: 'User is not admin' },
                HttpStatus.BAD_REQUEST,
            );
        }

        const comparePassword = await compare(signInDto.password, user.password);
        if (!comparePassword) {
            throw new HttpException(
                { message: 'Password is incorrect' },
                HttpStatus.BAD_REQUEST,
            );
        }

        return this.generateJwt(user);
    }

    generateJwt(user: users) {
        const payload = { username: user.username, sub: user.id };
        return {
            access_token: this.jwtService.sign(payload),
            user_info: {
                id: user.id,
                username: user.username,
                email: user.email,
                is_admin: user.is_admin,
            },
        };
    }
}
