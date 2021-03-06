"""empty message

Revision ID: a8b103e67e03
Revises: 9a5046cf2e78
Create Date: 2020-06-12 22:47:09.270069

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'a8b103e67e03'
down_revision = '9a5046cf2e78'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('bookmarks',
    sa.Column('bookmarkId', sa.Integer(), nullable=False),
    sa.Column('image', sa.String(length=255), nullable=True),
    sa.Column('name', sa.String(length=255), nullable=True),
    sa.Column('author', sa.String(length=255), nullable=True),
    sa.Column('evaluateBook', sa.Float(), nullable=True),
    sa.Column('description', sa.String(length=255), nullable=True),
    sa.Column('registrationDate', sa.Integer(), nullable=True),
    sa.Column('expirationDate', sa.Integer(), nullable=True),
    sa.Column('status', sa.Integer(), nullable=True),
    sa.Column('username', sa.String(length=255), nullable=True),
    sa.PrimaryKeyConstraint('bookmarkId')
    )
    op.create_table('carts',
    sa.Column('cartId', sa.Integer(), nullable=False),
    sa.Column('image', sa.String(length=255), nullable=True),
    sa.Column('name', sa.String(length=255), nullable=True),
    sa.Column('author', sa.String(length=255), nullable=True),
    sa.Column('evaluateBook', sa.Float(), nullable=True),
    sa.Column('description', sa.String(length=255), nullable=True),
    sa.Column('count', sa.Integer(), nullable=True),
    sa.Column('cost', sa.Float(), nullable=True),
    sa.Column('username', sa.String(length=255), nullable=True),
    sa.PrimaryKeyConstraint('cartId')
    )
    op.create_table('orders',
    sa.Column('orderId', sa.Integer(), nullable=False),
    sa.Column('image', sa.String(length=255), nullable=True),
    sa.Column('name', sa.String(length=255), nullable=True),
    sa.Column('author', sa.String(length=255), nullable=True),
    sa.Column('evaluateBook', sa.Float(), nullable=True),
    sa.Column('registrationDate', sa.Integer(), nullable=True),
    sa.Column('expirationDate', sa.Integer(), nullable=True),
    sa.Column('count', sa.Integer(), nullable=True),
    sa.Column('cost', sa.Float(), nullable=True),
    sa.Column('status', sa.Integer(), nullable=True),
    sa.Column('username', sa.String(length=255), nullable=True),
    sa.PrimaryKeyConstraint('orderId')
    )
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('orders')
    op.drop_table('carts')
    op.drop_table('bookmarks')
    # ### end Alembic commands ###
