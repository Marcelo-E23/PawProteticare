import { useEffect, useState } from 'react';
import { useNavigate, useParams, Link } from 'react-router-dom';
import endFetch from '../../../axios';
import Header from '../../../components/Header';
import Voltar from '../../../components/Voltar';
import style from './alterar.module.css';
import input from '../../../css/input.module.css';
import botao from '../../../css/botao.module.css'

export default function AlterarAnimadotado() {
    const { id } = useParams();
    const [animadotado, setAnimadotado] = useState({
        nome: '',
        especie: '',
        idade: '',
        status: '',
        historia:'',
        protese:'',
        imagem:'',
    });
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState('');
    const navigate = useNavigate();

    const getAnimadotado = async () => {
        try {
            const response = await endFetch.get(`/animadotado/${id}`);
            setAnimadotado(response.data);
            setLoading(false);
        } catch (error) {
            setLoading(false);
            setError('Erro ao carregar os dados do Animadotado');
            console.log(error);
        }
    };

    const handleChange = (e) => {
        const { name, value } = e.target;
        setAnimadotado((prevState) => ({
            ...prevState,
            [name]: value
        }))
        
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            await endFetch.put(`/animadotado/${id}`, animadotado);
            navigate('/AnimalAdotado')
        } catch (error) {
            setError('Erro ao salvar as alterações');
            console.log(error);
        }
    };

    useEffect(() => {
        getAnimadotado();
    }, [id]);

    if (loading) {
        return <div>Carregando...</div>;
    }

    return (
        <>  
            <Header/>
            <div className={style.login}>
                <form onSubmit={handleSubmit}>
                    <Link to={'/AnimalAdotado'}><Voltar/></Link>
                    <div className={input.input}>
                        <label htmlFor="nome" className="form-label">Nome</label>
                        <input
                            type="text"
                            className="form-control"
                            id="nome"
                            name="nome"
                            value={animadotado.nome}
                            onChange={handleChange}
                            required
                        />
                    </div>

                    <div className={input.input}>
                        <label htmlFor="especie" className="form-label">Espécie</label>
                        <input
                            type="text"
                            className="form-control"
                            id="especie"
                            name="especie"
                            value={animadotado.especie}
                            onChange={handleChange}
                            required
                        />
                    </div>

                    <div className={input.input}>
                        <label htmlFor="idade" className="form-label">Idade</label>
                        <input
                            type="number"
                            className="form-control"
                            id="idade"
                            name="idade"
                            value={animadotado.idade}
                            onChange={handleChange}
                            required
                        />
                    </div>

                    <div className={input.input}>
                        <label htmlFor="status" className="form-label">
                            Status:
                        </label>
                        <select
                        id="status" 
                        name="status" 
                        value={animadotado.status}
                        onChange={handleChange}
                        required>
                            <option value="APTO_PARA_ADOCAO">Apto para adoção</option>
                            <option value="AGUARDANDO_PROTESE">Aguardando protése</option>
                            <option value="ADOTADO">Adotado</option>
                            <option value="ANALISE_SITUACAO">Analisando situação</option>
                            <option value="FALECIDO">Falecido</option>
                    </select>
                    </div>

                    <div className={input.input}>
                        <label htmlFor="protese" className="form-label">N.Prótese</label>
                        <input
                            type="text"
                            className="form-control"
                            id="protese"
                            name="protese"
                            value={animadotado.protese}
                            onChange={handleChange}
                        />
                    </div>
                    <div className={input.input}>
                        <label htmlFor="historia" className="form-label">História</label>
                        <textarea
                            className="form-control"
                            id="historia"
                            name="historia"
                            value={animadotado.historia}
                            onChange={handleChange}
                        />
                    </div>
                    <div className={input.input}>
    <label htmlFor="imagem">Imagem do Animal</label>
    <input
        type="file"
        accept="image/*"
        onChange={(e) => {
            const file = e.target.files[0];
            const reader = new FileReader();
            reader.onloadend = () => {
                setAnimadotado((prevState) => ({
                    ...prevState,
                    imagem: reader.result
                }));
            };
            if (file) {
                reader.readAsDataURL(file);
            }
        }}
    />
</div>
                    {error && <div className={style.erroalterar}>{error}</div>}
                    <button type="submit" className={botao.bgreen}>Salvar Alterações</button>
                </form>
            </div>
        </>
    );
}
