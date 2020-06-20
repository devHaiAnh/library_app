"""empty message

Revision ID: 891edc9c9ce5
Revises: b32f319418fd
Create Date: 2020-06-15 14:46:49.811998

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '891edc9c9ce5'
down_revision = 'b32f319418fd'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('orders',
    sa.Column('orderId', sa.Integer(), nullable=False),
    sa.Column('image', sa.String(length=255), nullable=True),
    sa.Column('name', sa.String(length=255), nullable=True),
    sa.Column('author', sa.String(length=255), nullable=True),
    sa.Column('evaluateBook', sa.Float(), nullable=True),
    sa.Column('registrationDate', sa.BigInteger(), nullable=True),
    sa.Column('expirationDate', sa.BigInteger(), nullable=True),
    sa.Column('count', sa.Integer(), nullable=True),
    sa.Column('cost', sa.Float(), nullable=True),
    sa.Column('username', sa.String(length=255), nullable=True),
    sa.PrimaryKeyConstraint('orderId')
    )
    op.create_table('payments',
    sa.Column('paymentId', sa.Integer(), nullable=False),
    sa.Column('image', sa.String(length=255), nullable=True),
    sa.Column('name', sa.String(length=255), nullable=True),
    sa.Column('author', sa.String(length=255), nullable=True),
    sa.Column('evaluateBook', sa.Float(), nullable=True),
    sa.Column('registrationDate', sa.BigInteger(), nullable=True),
    sa.Column('count', sa.Integer(), nullable=True),
    sa.Column('cost', sa.Float(), nullable=True),
    sa.Column('username', sa.String(length=255), nullable=True),
    sa.PrimaryKeyConstraint('paymentId')
    )
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('payments')
    op.drop_table('orders')
    # ### end Alembic commands ###