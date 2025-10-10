import { useEffect, useState } from 'react';
import { useNavigate, useParams, Link } from 'react-router-dom';
import endFetch from '../../../axios';
import Header from '../../../components/Header';
import Voltar from '../../../components/Voltar';
import style from './alterar.module.css';
import input from '../../../css/input.module.css';
import botao from '../../../css/botao.module.css'

export default function AlterarProtese() {
    const { id } = useParams();
    const [protese, setProtese] = useState({
        nome: '',
        fabricante: '',
        custo: '',
        tipo: '',
        descricao:'',
    });
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState('');
    const navigate = useNavigate();

    const getProtese = async () => {
        try {
            const response = await endFetch.get(`/protese/${id}`);
            setProtese(response.data);
            setLoading(false);
        } catch (error) {
            setLoading(false);
            setError('Erro ao carregar os dados do protese');
            console.log(error);
        }
    };

    const handleChange = (e) => {
        const { name, value } = e.target;
        setProtese((prevState) => ({
            ...prevState,
            [name]: value
        }))
        
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            await endFetch.put(`/protese/${id}`, protese);
            navigate('/AnimalAchado')
        } catch (error) {
            setError('Erro ao salvar as alterações');
            console.log(error);
        }
    };

    useEffect(() => {
        getProtese();
    }, [id]);

    if (loading) {
        return <div>Carregando...</div>;
    }

    return (
        <>  
            <Header/>
            <div className={style.login}>
                <form onSubmit={handleSubmit}>
                    <Link to={'/AnimalAchado'}><Voltar/></Link>
                    <div className={input.input}>
                        <label htmlFor="nome" className="form-label">Nome</label>
                        <input
                            type="text"
                            className="form-control"
                            id="nome"
                            name="nome"
                            value={protese.nome}
                            onChange={handleChange}
                            required
                        />
                    </div>

                    <div className={input.input}>
                        <label htmlFor="fabricante" className="form-label">Fabricante</label>
                        <input
                            type="text"
                            className="form-control"
                            id="fabricante"
                            name="fabricante"
                            value={protese.fabricante}
                            onChange={handleChange}
                            required
                        />
                    </div>

                    <div className={input.input}>
                        <label htmlFor="custo" className="form-label">Custo</label>
                        <input
                            type="number"
                            className="form-control"
                            id="custo"
                            name="custo"
                            value={protese.custo}
                            onChange={handleChange}
                            required
                        />
                    </div>

                    <div className={input.input}>
                        <label htmlFor="tipo" className="form-label">
                            tipo
                        </label>
                        <input
                            type='text'
                            className="form-control"
                            id="tipo" 
                            name="tipo" 
                            value={protese.tipo}
                            onChange={handleChange}
                            required>   
                        </input>
                    </div>

                    <div className={input.input}>
                        <label htmlFor="descricao" className="form-label">Descrição</label>
                        <textarea
                            className="form-control"
                            id="descricao"
                            name="descricao"
                            value={protese.descricao}
                            onChange={handleChange}
                        />
                    </div>
                    {error && <div className={style.erroalterar}>{error}</div>}
                    <button type="submit" className={botao.bgreen}>Salvar Alterações</button>
                </form>
            </div>
        </>
    );
}
