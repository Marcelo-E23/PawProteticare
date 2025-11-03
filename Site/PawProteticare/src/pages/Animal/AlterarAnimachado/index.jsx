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
        imagem: '', // Base64 ou URL para preview
        file: null, // Para envio do arquivo
    });
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState('');
    const navigate = useNavigate();

    // Buscar dados do Animachado
    const getAnimachado = async () => {
        try {
            const response = await endFetch.get(`/animachado/${id}`);
            const data = response.data;
            setAnimachado({
                nome: data.nome,
                especie: data.especie,
                idade: data.idade,
                status: data.status,
                historia: data.historia,
                imagem: data.imagem ? `data:image/jpeg;base64,${data.imagem}` : '',
                file: null,
            });
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

    // Manipula arquivo e preview
    const handleFileChange = (e) => {
        const file = e.target.files[0];
        if (file) {
            const preview = URL.createObjectURL(file);
            setAnimachado((prev) => ({
                ...prev,
                imagem: preview,
                file: file,
            }));
        }
    };

    // Enviar alterações
    const handleSubmit = async (e) => {
        e.preventDefault();

        const formData = new FormData();
        formData.append("nome", animachado.nome);
        formData.append("especie", animachado.especie);
        formData.append("idade", animachado.idade);
        formData.append("status", animachado.status);
        formData.append("historia", animachado.historia);
        if (animachado.file) formData.append("imagem", animachado.file);

        try {
            await endFetch.put(`/animachado/${id}`, formData, {
                headers: {
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
                        {animachado.imagem && (
                            <div className={input.preview}>
                                <img
                                    src={animachado.imagem}
                                    alt="Preview do animal"
                                    style={{ maxWidth: '200px', marginTop: '10px' }}
                                />
                            </div>
                        )}
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
