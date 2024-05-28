import 'package:auto_route/auto_route.dart';
import 'package:bloc_boilerplate/features/home/bloc/users_bloc.dart';
import 'package:bloc_boilerplate/features/home/model/users_list_response/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<UsersBloc>().add(const UsersEvent.listUsers());
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SafeArea(
        child: BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) {
            if (state is UsersLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UsersListError) {
              return Center(
                child: Text(state.error),
              );
            }

            if (state is UsersListSuccess) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return _UserTile(item: state.data[index]);
                  },
                  separatorBuilder: (context, index) => const Gap(12),
                  itemCount: (state).data.length);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _UserTile extends StatelessWidget {
  const _UserTile({
    super.key,
    required this.item,
  });

  final UserData item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.firstName ?? ''),
      subtitle: Text(item.lastName ?? ''),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(item.avatar ?? ''),
      ),
    );
  }
}
