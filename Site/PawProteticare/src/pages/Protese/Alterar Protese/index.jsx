import { useEffect, useState } from 'react';
import { useNavigate, useParams, Link } from 'react-router-dom';
import endFetch from '../../../axios';
import Header from '../../../components/Header';
import Voltar from '../../../components/Voltar';
import style from './alterar.module.css';
import botao from '../../../css/botao.module.css';
import Input from '../../../modelos/Inputcadastro';

export default function AlterarProtese() {
    const { id } = useParams();
    const [protese, setProtese] = useState({
        nome: '',
        fabricante: '',
        custo: '',
        tipo: '',
        descricao: '',
    });
    const [message, setMessage] = useState('');
    const [loading, setLoading] = useState(true);
    const navigate = useNavigate();

    useEffect(() => {
        const fetchProtese = async () => {
            try {
                const response = await endFetch.get(`/protese/${id}`);
                setProtese(response.data);
            } catch (error) {
                setMessage('Erro ao carregar a prótese');
            } finally {
                setLoading(false);
            }
        };
        fetchProtese();
    }, [id]);

    // Função para atualizar campos específicos sem usar 'name'
    const handleChange = (campo, value) => {
        setProtese(prev => ({ ...prev, [campo]: value }));
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            await endFetch.put(`/protese/${id}`, protese);
            navigate('/Protese');
        } catch (error) {
            setMessage('Erro ao atualizar a prótese');
        }
    };

    if (loading) return <div>Carregando...</div>;

    return (
        <>
            <Header />
            <div className={style.login}>
                <form onSubmit={handleSubmit}>
                    <Voltar />

                    <Input
                        dado="Nome"
                        legenda="Digite o nome da prótese:"
                        tipo="text"
                        valor={protese.nome}
                        change={(e) => handleChange('nome', e.target.value)}
                        id="nome"
                    />

                    <Input
                        dado="Fabricante"
                        legenda="Digite o fabricante:"
                        tipo="text"
                        valor={protese.fabricante}
                        change={(e) => handleChange('fabricante', e.target.value)}
                        id="fabricante"
                    />

                    <Input
                        dado="Custo"
                        legenda="Digite o custo:"
                        tipo="number"
                        valor={protese.custo}
                        change={(e) => handleChange('custo', e.target.value)}
                        id="custo"
                    />

                    <Input
                        dado="Tipo"
                        legenda="Digite o tipo da prótese:"
                        tipo="text"
                        valor={protese.tipo}
                        change={(e) => handleChange('tipo', e.target.value)}
                        id="tipo"
                    />

                    <Input
                        dado="Descrição"
                        legenda="Digite a descrição:"
                        tipo="textarea"
                        valor={protese.descricao}
                        change={(e) => handleChange('descricao', e.target.value)}
                        id="descricao"
                    />

                    {message && <p className={style.erroalterar}>{message}</p>}

                    <button type="submit" className={botao.bgreen}>Salvar Alterações</button>
                </form>
            </div>
        </>
    );
}
