import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import endFetch from '../../axios';
import style from './login.module.css';
import botao from '../../css/botao.module.css'

const Login = () => {
  const [login, setLogin] = useState('');
  const [senha, setSenha] = useState('');
  const [error, setError] = useState('');
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      const loginData = await endFetch.get('/usuario/email');
      
      // Filtra apenas os usuários com tipo 'admin'
      const admins = loginData.data.filter((user) => user.tipousuario === 'ADMIN');

      // Verifica se o login e senha batem (usando email como login)
      const user = admins.find(
        (item) => item.email === login && item.senha === senha
      );

      if (user) {
        navigate('/home');
      } else {
        setError('Usuário ou senha incorretos');
      }
    } catch (error) {
      setError('Erro ao fazer login');
    }
  };

  return (
    <div className={style.login}>
      <form onSubmit={handleSubmit}>
        <div>
          <label htmlFor="usuario">Usuário (Email)</label>
          <input 
            type="text"
            id="usuario"
            value={login}
            onChange={(e) => setLogin(e.target.value)}
            required
            placeholder="Digite seu email"
          />
        </div>
        <div>
          <label htmlFor="senha">Senha</label>
          <input
            type="password"
            id="senha"
            value={senha}
            onChange={(e) => setSenha(e.target.value)}
            required
            placeholder="Digite sua senha"
          />
        </div>
        {error && <p className={style.erro}>{error}</p>}
        <button className={botao.bblue} type="submit">Entrar</button>
      </form>
    </div>
  );
};

export default Login;
