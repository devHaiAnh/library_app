"""empty message

Revision ID: fb3e81e4e40d
Revises: 35c0ff333996
Create Date: 2020-05-20 16:00:55.948997

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'fb3e81e4e40d'
down_revision = '35c0ff333996'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('carts',
    sa.Column('membertId', sa.Integer(), nullable=False),
    sa.Column('image', sa.String(length=255), nullable=True),
    sa.Column('name', sa.String(length=255), nullable=True),
    sa.Column('author', sa.String(length=255), nullable=True),
    sa.Column('evaluate', sa.Float(), nullable=True),
    sa.Column('description', sa.String(length=255), nullable=True),
    sa.Column('count', sa.Integer(), nullable=True),
    sa.Column('cost', sa.Integer(), nullable=True),
    sa.Column('username', sa.String(length=255), nullable=True),
    sa.PrimaryKeyConstraint('membertId')
    )
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('carts')
    # ### end Alembic commands ###
