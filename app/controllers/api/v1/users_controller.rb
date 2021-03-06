module Api

    module V1

        class UsersController < ApplicationController

          def index

             users = User.page(params[:page]).per(5)

              render json: users
              # ,
              #        meta: {
              #          pagination: {
              #            per_page: 5,
              #            total_pages: 10,
              #            total_objects: 150
              #          }
              #        }
            # @users = User.page(params[:page])

            # paginate json: @users, per_page: 5


            # render json: @users
          end

          def avatar

           user = User.find(params[:id])
           if user&.avatar&.attached?
            redirect_to rails_blob_url(user.avatar)
           else
            head :not_found
           end

          end

           def show
             @user = User.find(params[:id])

             render json: @user
           end
          def create
              @user = User.create(name: params[:name], avatar: params[:avatar])
              if @user.save
                render status: :created
              else
                render json: @user.errors, status: :unprocessable_entity
              end
          end

           def update
             @user = User.find(params[:id])
             @user.name = params[:name]
             @user.save

             render json: @user
           end

          def destroy
             @user = User.find(params[:id])
             @user.delete

             render status: :deleted
           end

          private

          def user_params
              params.require(:user).permit(:name, :avatar)
          end

        end

    end

end