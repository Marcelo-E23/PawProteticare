import styles from '../../css/input.module.css';

export default function Input({ dado, tipo, valor, change, legenda, id }) {
    return (
        <div className={styles.input}>
            <label htmlFor={id} className="form-label">{dado}</label>
            {tipo === 'textarea' ? (
                <textarea
                    id={id}
                    value={valor}
                    onChange={change}
                    placeholder={legenda}
                    required
                />
            ) : (
                <input
                    id={id}
                    type={tipo}
                    value={valor}
                    onChange={change}
                    placeholder={legenda}
                    required
                />
            )}
        </div>
    );
}
