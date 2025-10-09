import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import endFetch from '../../axios';
import style from './login.module.css';
import botao from '../../css/botao.module.css';

const Login = () => {
  const [login, setLogin] = useState('');
  const [senha, setSenha] = useState('');
  const [error, setError] = useState('');
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError(''); // limpa erro ao tentar novo login

    try {
      // Requisição POST para autenticar usuário
      const response = await endFetch.post('/auth/authenticate', {
        email: login,
        password: senha,
      });

      // Pega o token da resposta
      const { access_token } = response.data;

      // Salva token no localStorage
      localStorage.setItem('access_token', access_token);

      // Redireciona para página inicial
      navigate('/home');
    } catch (error) {
      // Se der erro, mostra mensagem genérica
      setError('Usuário ou senha incorretos');
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
