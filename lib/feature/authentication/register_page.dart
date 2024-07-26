import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo_app/product/constants/project_colors.dart';
import 'package:todo_app/product/constants/project_strings.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';
import 'package:todo_app/product/validators/validators.dart';
import 'package:todo_app/product/widgets/project_button.dart';
import 'package:todo_app/product/widgets/project_password_textfield.dart';
import 'package:todo_app/product/widgets/project_textfield.dart';

class RegisterPage extends HookWidget{
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.dynamicHeight(0.12),
        centerTitle: true,
        title: SizedBox(
          height: context.dynamicHeight(0.10),
          child: Column(
            children: [
              SizedBox(height: context.mediumValue,),
              Text(ProjectStrings.registerButton,style: context.textTheme().titleLarge,),
              Text(ProjectStrings.supTitle,style: context.textTheme().titleSmall?.copyWith(color: ProjectColors.grey),)
            ],
          ),
        ),
        leading: Padding(
          padding:  EdgeInsets.only(top: context.mediumValue,right: context.lowValue1),
          child: Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: (){Navigator.pop(context);},
              icon: const Icon(Icons.arrow_back_outlined))),
        ),
      ),
      body: Column(
        children: [
          const Divider(
            color: ProjectColors.black,
            thickness: 1.5,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: context.paddingHorizontalHeigh,
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       SizedBox(height: context.dynamicHeight(0.08),),
                       Text(ProjectStrings.userName,style: context.textTheme().titleMedium,),
                       SizedBox(height: context.lowValue1,),

                       ProjectTextfield(hintText: ProjectStrings.tfUserNameHint, controller: nameController, keyBoardType: TextInputType.name, validator: Validators().validateName),

                       SizedBox(height: context.lowValue1,),
                       Text(ProjectStrings.emailText,style: context.textTheme().titleMedium,),
                       SizedBox(height: context.lowValue1,),

                       ProjectTextfield(hintText: ProjectStrings.tfEmailHint, controller: emailController, keyBoardType: TextInputType.emailAddress, validator: Validators().validateEmail),

                       SizedBox(height: context.lowValue1,),
                       Text(ProjectStrings.passwordText,style: context.textTheme().titleMedium,),
                       SizedBox(height: context.lowValue1,),

                       ProjectPasswordTextfield(hintText: ProjectStrings.tfPasswordHint, controller: passwordController, keyBoardType: TextInputType.visiblePassword, validator: Validators().validatePassword,),

                       SizedBox(height: context.lowValue1,),
                       Text(ProjectStrings.confirmText,style: context.textTheme().titleMedium,),
                       SizedBox(height: context.lowValue1,),

                       ProjectPasswordTextfield(hintText: ProjectStrings.tfConfirmHint, controller: confirmController, keyBoardType: TextInputType.visiblePassword,validator:(value) => Validators().validateConfirmPassword(value, passwordController.text)),
                       
                       SizedBox(height: context.dynamicHeight(0.08)),
                       ProjectButton(
                        text: ProjectStrings.registerButton, 
                        onPressed: (){
                          if(formKey.currentState?.validate() ?? false){
                      
                          }
                        }),
                        SizedBox(height: context.highValue,)
                    ],
                  ),
                ),
              ),
            ),
          )
         
      
      
        ],
      ),
    );
  }
}