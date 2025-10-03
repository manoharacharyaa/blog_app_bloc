import 'package:blog_app_bloc/core/error/failure.dart';
import 'package:blog_app_bloc/core/usecase/usecase.dart';
import 'package:blog_app_bloc/features/blog/domain/enteties/blog.dart';
import 'package:blog_app_bloc/features/blog/domain/reopsitories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;

  GetAllBlogs(this.blogRepository);

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return blogRepository.getAllBlogs();
  }
}
