abstract class States {}

class InitialState extends States{}

//User Info
class GetUserLoadingState extends States{}
class GetUserSuccessState extends States{}
class GetUserErrorState extends States{
  final String error;

  GetUserErrorState(this.error);
}

//Get Posts
class GetPostsLoadingState extends States{}
class GetPostsSuccessState extends States{}
class GetPostsErrorState extends States{
  final String error;

  GetPostsErrorState(this.error);
}

//Get All Users
class GetAllUsersLoadingState extends States{}
class GetAllUsersSuccessState extends States{}
class GetAllUsersErrorState extends States{
  final String error;

  GetAllUsersErrorState(this.error);
}

//Make Like
class LikePostsSuccessState extends States{}
class LikePostsErrorState extends States{
  final String error;

  LikePostsErrorState(this.error);
}

//Get Likes
class GetLikesLoadingState extends States{}
class GetLikesSuccessState extends States{}


//Change Bottom NevBar
class ChangeBottomNavState extends States{}

//Add Post Screen
class NewPostState extends States{}

//Pick An Profile Image
class ProfileImagePickedSuccessState extends States{}
class ProfileImagePickedErrorState extends States{}

//Upload An Profile Image
class UploadProfileImageSuccessState extends States{}
class UploadProfileImageErrorState extends States{}

//Pick An Cover Image
class CoverImagePickedSuccessState extends States{}
class CoverImagePickedErrorState extends States{}

//Upload An Cover Image
class UploadCoverImageSuccessState extends States{}
class UploadCoverImageErrorState extends States{}

//Update User`s Data
class UserUpdateLoadingState extends States{}
class UserUpdateErrorState extends States{}

//User Create New Post
class UserCreatePostLoadingState extends States{}
class UserCreatePostSuccessState extends States{}
class UserCreatePostErrorState extends States{}

//Pick A Post Image
class PostImagePickedSuccessState extends States{}
class PostImagePickedErrorState extends States{}

//Remove A Post Image
class RemovePostImageState extends States{}

//Send Message
class SendMessageSuccessState extends States{}
class SendMessageErrorState extends States{}

//Get Messages
class GetMessageSuccessState extends States{}
class GetMessageErrorState extends States{}


