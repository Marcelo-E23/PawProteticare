import { useEffect, useState } from 'react';
import { useNavigate, useParams, Link } from 'react-router-dom';
import endFetch from '../../../axios';
import Header from '../../../components/Header';
import Voltar from '../../../components/Voltar';
import style from './alterar.module.css';
import input from '../../../css/input.module.css';
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
        animalId: ''
    });
    const [animalInfo, setAnimalInfo] = useState(null);
    const [message, setMessage] = useState('');
    const [loading, setLoading] = useState(true);
    const navigate = useNavigate();

    useEffect(() => {
        const fetchProtese = async () => {
            const token = localStorage.getItem('access_token');
            try {
                const response = await endFetch.get(`/protese/${id}`,{
                    headers: {
                        Authorization: `Bearer ${token}`,
                             },
                    });
                setProtese(response.data);
            } catch (error) {
                setMessage('Erro ao carregar a prótese');
            } finally {
                setLoading(false);
            }
        };
        fetchProtese();
    }, [id]);

    // Busca animal sempre que animalId mudar
    useEffect(() => {
        const fetchAnimal = async () => {
            if (!protese.animalId) {
                setAnimalInfo(null);
                return;
            }
            try {
                const response = await endFetch.get(`/animadotado/${protese.animalId}`,{
                    headers: {
                        Authorization: `Bearer ${token}`,
                             },
                    });
            } catch (error) {
                setAnimalInfo(null);
            }
        };
        fetchAnimal();
    }, [protese.animalId]);

    const handleChange = (e) => {
        const { name, value } = e.target;
        setProtese(prev => ({ ...prev, [name]: value }));
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        if (!animalInfo) {
            setMessage("Informe um ID de animal válido.");
            return;
        }

        try {
            // Verifica se já existe prótese para o mesmo animal, exceto essa
            const check = await endFetch.get(`/protese?animalId=${protese.animalId}`);
            if (check.data.length > 0 && check.data[0].id !== Number(id)) {
                setMessage(`O animal com ID ${protese.animalId} já possui uma prótese.`);
                return;
            }

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
                    <Link to={'/Protese'}><Voltar /></Link>

                    <Input dado="Nome" legenda="Digite o nome da prótese:" tipo="text" valor={protese.nome} change={handleChange} name="nome" />
                    <Input dado="Fabricante" legenda="Digite o fabricante:" tipo="text" valor={protese.fabricante} change={handleChange} name="fabricante" />
                    <Input dado="Custo" legenda="Digite o custo:" tipo="number" valor={protese.custo} change={handleChange} name="custo" />
                    <Input dado="Tipo" legenda="Digite o tipo da prótese:" tipo="text" valor={protese.tipo} change={handleChange} name="tipo" />
                    <Input dado="Descrição" legenda="Digite a descrição:" tipo="textarea" valor={protese.descricao} change={handleChange} name="descricao" />

                    <div className={input.input}>
                        <label htmlFor="animalId">ID do Animal</label>
                        <input
                            type="number"
                            id="animalId"
                            name="animalId"
                            value={protese.animalId}
                            onChange={handleChange}
                            placeholder="Digite o ID do animal"
                            required
                        />
                    </div>

                    {animalInfo && (
                        <div className={style.animalInfo}>
                            <p><strong>Nome:</strong> {animalInfo.nome}</p>
                            <p><strong>Espécie:</strong> {animalInfo.especie}</p>
                        </div>
                    )}

                    {message && <p className={style.erroalterar}>{message}</p>}
                    <button type="submit" className={botao.bgreen}>Salvar Alterações</button>
                </form>
            </div>
        </>
    );
}
