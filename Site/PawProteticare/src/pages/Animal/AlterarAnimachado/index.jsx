import { useEffect, useState } from 'react';
import { useNavigate, useParams, Link } from 'react-router-dom';
import endFetch from '../../../axios';
import Header from '../../../components/Header';
import Voltar from '../../../components/Voltar';
import style from './alterar.module.css';
import input from '../../../css/input.module.css';
import botao from '../../../css/botao.module.css';

export default function AlterarAnimachado() {
    const { id } = useParams();
    const [animachado, setAnimachado] = useState({
        nome: '',
        especie: '',
        idade: '',
        status: '',
        historia: '',
        protese: '',
        imagem: null, // guardar arquivo
    });
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState('');
    const navigate = useNavigate();

    // Buscar dados do Animachado
    const getAnimachado = async () => {
        const token = localStorage.getItem('access_token');
        try {
            const response = await endFetch.get(`/animachado/${id}`, {
                headers: {
                    Authorization: `Bearer ${token}`,
                },
            });
            // Aqui podemos manter a imagem como null (ou url) se for necessário exibir
            setAnimachado((prev) => ({
                ...response.data,
                imagem: null,
            }));
            setLoading(false);
        } catch (error) {
            setLoading(false);
            setError('Erro ao carregar os dados do Animachado');
            console.log(error.response ? error.response.data : error);
        }
    };

    useEffect(() => {
        getAnimachado();
    }, [id]);

    // Atualiza campos do formulário
    const handleChange = (e) => {
        const { name, value } = e.target;
        setAnimachado((prev) => ({
            ...prev,
            [name]: value,
        }));
    };

    // Atualiza o arquivo selecionado
    const handleFileChange = (e) => {
        const file = e.target.files[0];
        if (file) {
            setAnimachado((prev) => ({
                ...prev,
                imagem: file,
            }));
        }
    };

    // Enviar alterações
    const handleSubmit = async (e) => {
        e.preventDefault();
        const token = localStorage.getItem('access_token');

        try {
            const formData = new FormData();
            formData.append('nome', animachado.nome);
            formData.append('especie', animachado.especie);
            formData.append('idade', animachado.idade);
            formData.append('status', animachado.status);
            formData.append('historia', animachado.historia);
            formData.append('protese', animachado.protese);
            if (animachado.imagem) {
                formData.append('imagem', animachado.imagem); // arquivo real
            }

            await endFetch.put(`/animachado/${id}`, formData, {
                headers: {
                    Authorization: `Bearer ${token}`,
                    'Content-Type': 'multipart/form-data',
                },
            });

            navigate('/AnimalAchado');
        } catch (error) {
            setError('Erro ao salvar as alterações');
            console.log(error.response ? error.response.data : error);
        }
    };

    if (loading) return <div>Carregando...</div>;

    return (
        <>
            <Header />
            <div className={style.login}>
                <form onSubmit={handleSubmit}>
                    <Link to={'/AnimalAchado'}><Voltar /></Link>

                    <div className={input.input}>
                        <label htmlFor="nome">Nome</label>
                        <input
                            type="text"
                            id="nome"
                            name="nome"
                            value={animachado.nome}
                            onChange={handleChange}
                            required
                        />
                    </div>

                    <div className={input.input}>
                        <label htmlFor="especie">Espécie</label>
                        <input
                            type="text"
                            id="especie"
                            name="especie"
                            value={animachado.especie}
                            onChange={handleChange}
                            required
                        />
                    </div>

                    <div className={input.input}>
                        <label htmlFor="idade">Idade</label>
                        <input
                            type="number"
                            id="idade"
                            name="idade"
                            value={animachado.idade}
                            onChange={handleChange}
                            required
                        />
                    </div>

                    <div className={input.input}>
                        <label htmlFor="status">Status</label>
                        <select
                            id="status"
                            name="status"
                            value={animachado.status}
                            onChange={handleChange}
                            required
                        >
                            <option value="APTO_PARA_ADOCAO">Apto para adoção</option>
                            <option value="AGUARDANDO_PROTESE">Aguardando prótese</option>
                            <option value="ADOTADO">Adotado</option>
                            <option value="ANALISE_SITUACAO">Analisando situação</option>
                            <option value="FALECIDO">Falecido</option>
                        </select>
                    </div>

                    <div className={input.input}>
                        <label htmlFor="historia">História</label>
                        <textarea
                            id="historia"
                            name="historia"
                            value={animachado.historia}
                            onChange={handleChange}
                        />
                    </div>

                    <div className={input.input}>
                        <label htmlFor="imagem">Imagem do Animal</label>
                        <input
                            type="file"
                            id="imagem"
                            accept="image/*"
                            onChange={handleFileChange}
                        />
                    </div>

                    {error && <div className={style.erroalterar}>{error}</div>}

                    <button type="submit" className={botao.bgreen}>
                        Salvar Alterações
                    </button>
                </form>
            </div>
        </>
    );
}
