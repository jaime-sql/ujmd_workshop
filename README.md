# Sivar Express — Database (UJMD Workshop)

**Asignatura:** Arquitectura de Datos en Entornos Digitales  
**Universidad:** Dr. José Matías Delgado (UJMD)

---

## 📐 Schema Overview

Modelo relacional en **3FN** para el sistema de delivery "Sivar Express".

| Tabla | Descripción |
|---|---|
| `departamento` | Catálogo de departamentos de El Salvador |
| `municipio` | Municipios vinculados a cada departamento |
| `cliente` | Clientes con dirección normalizada |
| `repartidor` | Personal de entrega y vehículos asignados |
| `producto` | Catálogo de productos y precio vigente |
| `pedido` | Cabecera de pedidos |
| `detalle_pedido` | Desglose de productos por pedido (tabla asociativa N:M) |

---

## 🚀 CI/CD Pipeline

This repository is connected to **Supabase** via **GitHub Actions**.

### How it works

1. Add a new `.sql` file inside `supabase/migrations/` following the naming convention:
   ```
   YYYYMMDDHHmmss_description.sql
   ```
2. Commit and push to `main`:
   ```bash
   git add supabase/migrations/
   git commit -m "feat: add new migration"
   git push origin main
   ```
3. GitHub Actions automatically runs `supabase db push` to apply the migration to your Supabase project.

### Pipeline triggers

The workflow runs **only when** files inside `supabase/migrations/` change on a push to `main`.

---

## 🔑 Required GitHub Secrets

Go to your GitHub repo → **Settings → Secrets and variables → Actions** and add:

| Secret | Where to find it |
|---|---|
| `SUPABASE_ACCESS_TOKEN` | [supabase.com/dashboard/account/tokens](https://supabase.com/dashboard/account/tokens) |
| `SUPABASE_PROJECT_REF` | Your project URL: `https://supabase.com/dashboard/project/<ref>` |
| `SUPABASE_DB_PASSWORD` | Project Settings → Database → Database password |

---

## 📁 Project Structure

```
ujmd_workshop/
├── .github/
│   └── workflows/
│       └── deploy.yml          # GitHub Actions CI/CD pipeline
├── supabase/
│   └── migrations/
│       └── 20260810000000_initial_schema.sql
├── create_database/
│   ├── create_database.sql     # Original DDL (reference)
│   └── reporte.sql             # Query examples
└── .gitignore
```

---

## 🛠️ Adding Future Migrations

Never edit existing migration files. Instead, create a **new** file:

```bash
# Example: adding a new column
# File: supabase/migrations/20260815120000_add_email_to_cliente.sql

ALTER TABLE cliente ADD COLUMN IF NOT EXISTS email VARCHAR(255);
```

Then commit and push — the pipeline will deploy it automatically.
