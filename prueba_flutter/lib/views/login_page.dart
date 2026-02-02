import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final AuthController controller = Get.find<AuthController>();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  final String logoBase64 =
      '''data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAASwAAADSCAYAAADwkv2oAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEgAACxIB0t1+/AAAABZ0RVh0Q3JlYXRpb24gVGltZQAwOS8xOC8xORNWKgkAAAAcdEVYdFNvZnR3YXJlAEFkb2JlIEZpcmV3b3JrcyBDUzbovLKMAAAUf0lEQVR4nO3de5QkZXnH8e8zu7MXFpZluYSL7CYiEAE3sHIJJ+AtiRdQiXr0hKABjIhGTgJGBfESJQcFg7lwjIIGQdCjESVxcSVIcjwJGK6HiwtLVu7gggtyWdj7zsyTP54qpqamu6q6p7tn3/j7nNNnZnq6q97uqvrVW2+99Za5OyIiKRia7gKIiDSlwBKRZCiwRCQZCiwRSYYCS0SSocASkWQosEQkGQosEUmGAktEkqHAEpFkKLBEJBkKLBFJhgJLRJKhwBKRZCiwRCQZCiwRSYYCS0SSocASkWQosEQkGQosEUmGAktEkqHAEpFkKLBEJBkKLBFJhgJLRJKhwBKRZCiwRCQZCiwRSYYCS0SSocASkWQosEQkGQosEUmGAktEkqHAEpFkKLBEJBkKLBFJhgJLRJKhwBKRZCiwRCQZCiwRSYYCS0SSocASkWQosEQkGQosEUmGAktEkqHAEpFkKLBEJBkKLBFJhgJLRJKhwBKRZCiwRCQZCiwRSYYCS0SSocASkWQosEQkGQosEUmGAktEkqHAEpFkKLBEJBkKLBFJhgJLRJKhwBKRZCiwRCQZCiwRSYYCS0SSocASkWQosEQkGQosEUmGAktEkqHAEpFkKLBEJBkKLBFJhgJLRJKhwBKRZCiwRCQZCiwRSYYCS0SSocASkWTMnK4Zm9lMYDYwDGwCNrn7dBVHRBJggw4JMwM4HHgH8HJgAfAE8N/A99x9zUALJCLJGEhgmRn5fMzs/cDngYUtXvpT4L3u/vO+F0pEkjPQwDKzNwPfB2ZVvPxG4C3u/nTfCyYiSRlIo3sWVvOBT1AdVgBHAif1vVAikpxBniU8Clja8LXHZo3yIiIvGmRgvZT62lVuMbB7H8siIgkaZGCNdPDarcBYvwoiImkaZGDdDfyqg9f+so9lEZEEDTKwbgKub/C6MeBf3V01LBGZYGCB5e4jRP+rB2peegnR9UFEZIKBXkvo7rcC7wNuZXKb1jPARcAZ7r5pkOUSkTQM/NIcADPbGTgOOAzYHlgN/MTdrx14YUQkGdMSWCIi3bDsMUw2coO7b5jWEjWQXUA9j+j+sEWhK/LrwYD5wMuAlwC7AXsBi4gQs+x1W4HR7OcWIE+IvA3MCz/z91Qpvq7qd4A52WM4+3sL8DBwH3C3u69oMD/MbAYxSsSc7LM0LWdRfubSiDa4UWCtu69qUoZSebYHfos4JJ5F7DAMmFF+aakco9nfY8SwPBuBX7h7ZZcRM9sJ+B1imY3Q7PNTmne+fMay30eBZ6ouVjezucSh/zxgfeEzQXzm9cBt2UmZRsxsd2AJsLlUviFiyKJ73P0X2Wdeks1nK80/cxMOzCXWxZ97ttc0sx2AQ4hluqUH88y/8znAk8CKdt9V9nkPAbYjvu852b9mFMoxg/Htdqjw/CixXoxk5d6cPZ4DbqqY597AAcS6mJe1WOYH3f2+ug+ZNRMtYXL/y3xaw8D9+Qrzv8CDxMJeTATYjsCewIHAvsAuRKANetC/tcAaYCXRLeJh4F5iSJqNZrYLsB8RvNe7+/o209kBuJgI5E6Ctep/Dqw3sweIbhsXuvuT7d5gZrOBPwWOAfYA9iZW7OKKU1eu4s5hjFjRHjez1cAtwEXu/lSL9y0Fvk2ssE0/f3F+7f73gpk9BDwNXAd8q1RL30x83g8SG0Nx3paV/1zgH5oUxsz2yD7HEsaXQW4IeAh4Z/b3UuByIljG6H1gzQAuBc4kAhHgoKx8vZpn/n0NEcv3BEr9Gc3sMOD9wBFExWOIicFULEO7373wGCv8HAEeMLMvA5f75MOZPwbOLrynGFhDxHfx5w0+5+HAV4mwLcqnZcC5uPukR+HDzCRScj5RGzgKOBn4IrAcWEEESl7r6vYxmk3jaeAO4HvAJ4kVfRExZtaORG1kX+ANxErynawM64CzyNrk2nymBUTj/lTKWfUYAZYB27WZ/27AVYzXCvpVhtuBJS3m/0bGA6Nfj81EaL2sNO9dgKsr3vc88KZ2y64wHQP+uWb+x+XrQfaZN/b5M38NmFUo49HAhj7N60Zg59J2+h4iwPr5GZ2oQX0EKC+TT9S874q65ZpN5y0NvrdP1U6oZibzsgV0EvB1Yu+2tuGHXwOsAn4EfBh4O7B/Nt0hYCdib/HK7Eu5lBjkb12L6f0QWFhT1h2J2lk/F+pG4MQ2O4C/HcBKlT+uBRaUyvB6+r/x5o/lwOzS/BcBN1e852f58q9YhqfSfuc4QnSJKb7+D4kw7Odn/QoTA+v3aLYNdPO4gYmBtRR4akDL1IFHgH1K3/FZNe/5esMsOabB93b2lEZEyA6/rs8el5nZdsRK8jbgdcQhD0TN6SnisHMFcA9wg7s/BGBmw8TFznub2QeIQ9Ijier1/JpirAJOd/dnal6XVyv7aQ5Rtf1G6fndgeP7PO+i1xPf3zWF5/Iq+yC8kagFL8ufcPdHzewviFrmni3e8wrgIjN7R6tlaWZHEYeOw5PeGS4HLiw9N4toCuinuaW/+7mezSv9fTJRex2URcRhZ7Hzd9MmjDpNvrehng7hkrVd/AD4gZktBY4FXgBucff/ebFkZrsCu5vZCcDBwG9nP1/S4SyfAd7n7vf3ovxEoN7J5Hae/Hh8XlbOnSqm0ep/BwK/0WD+TxB7mTxcigs7L8MwEeh1Djaza0qH+HUrxHrgMaIWU2z8L5bjN4lD8ypDRGguKz7p7jeb2elEuMxp8b7XAH8N/GXxyaxB9kvAzm3mdwtwpruPlp5fR+zQ5jKxo3JeI9uV1iPfFm0gjgZatUfNIq557fQysluB+7NyNdngjThCuJk4OslPIh3dcH4riQrDhqys+WNG9phNtB3tQ3wnVaZ1FJW+jTnl7rcT7SmY2WIzezfR0HwE0WC6K9Gu1K3ngJPc/Yb8ieJQzF1a5u5nmFnxxEK+wgwRG9nHiUbGdlrVAPKG/nbWE43Oy4n2iFEmbwTFMhxK1Db2qpjmnsTy7WSUjDuADxE7gvK6kX8PB2XzXlIzrQPNbMhL14S6+5Vm9grgU23ed5qZ3enulxaeO584w9nKGmJY7VYnGm4D3sX4WUIYP8u5BXh3RTmK0/gYsYyGGP8enAicx+nsOwY4z92vKq1ndQwY8/EVfDYRYlXGiBrtmUSwbiXKnS+T/GTPTCJ8f5c4MbW4phyd2Njwdb+iQfD3fZA8i05THyCOdXtlPXCqu1/dw2lC7JEpb2SML+R1ZnZPg7KV7UD1gv6+u3+ycSnhnuzs6OdoP8bYAiI8O9mYNgL3uvvWitc8nNWQL6b94RnEzmk+sWMpO5eodb69xf+GgAvMbGVWIzuFOPRpZRT4iLu3XCZZk8XP2hXQzJrUzJ9195sbvK4Ta6DletaJYvC08wJwvrs/2Ob/+fu3Esv+WjN7jOrAajqmXe4QM3svsVzzwIeJZxNHiCOX2XUT63tgubub2XVEg2nVoVRTa4EPuvt3W8xrqtPexcx2Y/xwqHhY6ESt8ISaabTqk7QH1d1B2m5UFW4kGpTbtWFsR+d7w3yvXTcM0Eri8KJqDz+TOHScFFjuvjlrz1pMnFQpWwicb2YXAp+h/Xf398A3a8papUkNf7aZ7ejua6cwn7ITzewAYuNvckg4m1gmV7v7sx3MZy2dD9P0FLHTzcekK67/O9B6h1zlSOKoqtVRS/4zPzytNahhiB8jVtypBtZjwGnuvqz2ld15J9EuUP7y8iScR3U72yqiq0XZQqpXzG4u9t5Ede1pNv3rM/ccsfeuCqz8ELYld19tZqcB/0br9r1XE50g2510WQ58ugc7qelwMtEdodFGSnyPjxI7tk4Caz1RC+3Eh4nttNiviuzv2cSZ9k606wxd/Nn0exhYYO1D5w3qZfcAp7j7jT0oTzs7075ht86PgY+2qX7XNXh3E1h5j/d28p7z/ZD3iq7SakWdwN1vMrNPE10DWoVbu7C6m+jC0LR9ZFszk863vVaH33VpvYXxtrtG3P1hOg+lgRlUr/U/oLq9o4oTfbWO7XNYTdVi4LjsspFOdboXhPpuCt2EVfnM5FRe1/T0/leBzzacL8QJgTO9weUe/8+02lbrvrNtofo5SuyQNzN+yU/x55bs//kJgUqDaHTfl7jLczc2Ej2JzxrQ3nQdcbjTakPLj7nn07pvz/7AOcABZnaiu2/pYL7d7DiKl/O00k0IdjLvumq8NymDxy3gPkc0wr+r5uVjwDnu/qNGpdx2rSUO15puf0Y01Je7ZtRt4HlD93S6jej0PdymLEYE1lLgRGoa3gdxSPghou9Op54Aznb3y3pammpXAecx8XCq2K1hjOgY+ne075B4LNGf6MeF515gYntAWadnXprIL8PpRNNa0TwmX/NVNkbDwxF3HzGzvyJqqUdUvPQy4B+bTHMbdz7RqXcezRrdh4l1qHxWs275zm4w/QnM7HCi42/eV61oO+AuYgjzpjvEO9z94gbzfTVxXeL0BZaZvZa4KLNTtxFtFDfUvrK3HnX3e6teYGYriAbTV7V5yQ5EbasYWI9RfSak6jRyO4uo7sW9ns47NI7QrD1tMfVXIGwlNrJGPEZXuJQ4a9hqvRwFvphoI3vZLe5+5xSn0aQGu4DJPfHrHA+cXvH/64kTHk2PeGq7KmS2p0G49q26aGYLgAvo/Au7CPijaQgraHa2YlfqewOXv9d1VIfH8Wb21mzImUpmNpTtBc+iusf5Wjrv0GhkK5iZDWePmdlj2Mzmmtkriavv69okV9NBYGW2VpS5VWfaVPWqolC3ge9MHGY1m5jZHOpvdry5wXy70Wia/axhnUfzOz1DrOAfd/cr+lSeJo7Nrocsfi9jTGwL2I+oQbXTqgqwpma+i4FvAXeZ2QvERptfPpHL243mZPOvO+v6JNGg2YmDgSvNbCsTAyk/nJ2ZlXVRzXQcWNlFbag4BlvZEP05dJ4OZ5jZa2hWq8jbqnYkDgm/lPXF2kp9n6iZwMeyncxDRJ+sjYyvF/nZyrnETvgQot9UlXxEhV5rNM2eBFb5kpjserFTOpjEd4HP1B2ODcAS6i85qeNMDopVxKFWVa1ke+JK/15Z1UVg7AS8tgfzNmJkAWntDdmjUw8SO7Zn3X3MzJbTuuNt0XbE0C25vKZqhUcnR1qr6azm3nQlbPS6KR8SZsMVF/9+G3EBa5NpPwKcBvzZAMKq6Sn7qXqOyb3dHyK6ZgzKCuCnpecG9fkheuH/exfvqypjP8rfqy4cU3l9J8rtkl8hhlzqxAzGh0QvDvLX1Eomnkzp5Wet7aYx5cAqjvlkZq8jrqqvu+RhC1GrehPwT+6+bqrlaKC2I2MPjBENkj8pPpldM/YFoqbVb88R3SseLj0/RP/PCo8Ro8Ge7u7Pd/H+qu4S/egI22T9Lw4v3HSa/fqeJ5TD3X9JXMD9TeJQrd/uAq4p1dzrtqlOevPXvbZ3w8uY2aHEBbGtxjoqeoDoFvC1motse80Y7/k71b1C8f1jROPys0St4vOtLmp199vN7Djgo8Rh1zziMLDYblM3TLKXfs/PFG0griu8F/iCu/9Xi/fmQ+bk7WOdbvzl7+zFC8KzeT8P/AfRxvJoh9POFUdVKF9v5vR+hzOjxfyKv+d93ToNrKl8z63kn33SmWZ3f8zMTiRC63hiJI9dibO4ecgXH03lbagjxLK9ibgUqnwj5JmMD9Vd7rqTr3NN5NvnLFovC4DRntzmKxsu5NtE57921hH9nM5p8aH7LhtP/T1E7a+TmzAU5Rtp8ecmYkz8+71iPPdSWRYSQ04fQLQb5dXzfCMpj/Geh1OxIT6/YcB6ojH2Pnd/vGKei4nREYbp7oYMxUOdfAXdRBz+Pki0q0xpL29mS4DfZ7zPW/7Z87+v8JqbbXQ4v0OIqzDy4C9vJHOIncDyph2BzWwvoqP0HHp344t8KJvVwFXu3vbsq5nNJ4YRP5RoqM8P/4azxyzGb3qSd+bML0DeSizTDdmjeBOKu9rM7whi7LP1TA6seUQXjtr7jZrZS4E3Z2UqX3Sd//6fUw4sM9sfuJIYMbKdO4hhLv5lSjOTrvRgnDCRnutmvez4kLA4EzPbh6hZtQurJ4FLiLvJdDrMhUhytHPor67bsMxsP+IU6yFtXrKMGFlxW75g+deCNiDZFnWzXnZ1SGhmLyca+Vp1DH0E+Bvgyi7PFImItNTNIeFS4q4wB5X+tZkYAfLibEwdEZGe6iiwsouZLyHOcOVGidP55wC3e3ZLax3Li0ivNT4kNLNjiLGp8n5WI8Tp/AuJW1hv7ksJRUQyjWpYZvYnwJcZH8P7EeKW4Ze4+xN9KpuIyAS1gWVmpxJhNUTcwXkZcIG7r+xz2UREJmgbWNn9BD/L+I0mf0j0p7puEAUTESlrGVjZHWm/QVxYeQ9x7d8VA772T0RkgkmN7tldX75DDOR1PtFO9cg0lE1EZIIJNSwzexUxUuhq4DB37+aOxCIifWGF6wKPBt5KjBR5XfnKe/WrEpHpZtl94RYSd2d+wN2fme5CiYi00pPxsEREBmG67worItKYAktEkqHAEpFkKLBEJBkKLBFJhgJLRJKhwBKRZCiwRCQZCiwRSYYCS0SSocASkWQosEQkGQosEUmGAktEkqHAEpFkKLBEJBkKLBFJhgJLRJKhwBKRZCiwRCQZCiwRSYYCS0SSocASkWQosEQkGQosEUmGAktEkqHAEpFkKLBEJBkKLBFJhgJLRJKhwBKRZCiwRCQZCiwRSYYCS0SSocASkWQosEQkGQosEUmGAktEkqHAEpFkKLBEJBkKLBFJhgJLRJKhwBKRZCiwRCQZCiwRSYYCS0SSocASkWQosEQkGQosEUmGAktEkqHAEpFkKLBEJBkKLBFJhgJLRJKhwBKRZCiwRCQZCiwRSYYCS0SSocASkWQosEQkGQosEUmGAktEkqHAEpFkKLBEJBkKLBFJhgJLRJKhwBKRZCiwRCQZCiwRSYYCS0SSocASkWQosEQkGQosEUmGAktEkqHAEpFkKLBEJBkKLBFJhgJLRJLxf20GGTdPNJqUAAAAAElFTkSuQmCC''';

  Image _buildLogo() {
    final pureBase64 = logoBase64.split(',').last;
    return Image.memory(
      base64Decode(pureBase64),
      height: 140,
      fit: BoxFit.contain,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// LOGO
              _buildLogo(),
              const SizedBox(height: 24),

              /// TITULO
              const Text(
                'Bienvenido',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Inicia sesión para continuar',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),

              /// EMAIL
              TextField(
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              /// PASSWORD
              TextField(
                controller: passCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              /// BOTON LOGIN
              Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.login(
                              emailCtrl.text.trim(),
                              passCtrl.text.trim(),
                            );
                          },
                          child: const Text(
                            'Ingresar',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
              ),

              const SizedBox(height: 12),

              /// REGISTRO
              TextButton(
                onPressed: () => Get.toNamed('/register'),
                child: const Text('Crear cuenta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
