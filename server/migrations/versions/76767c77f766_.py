"""empty message

Revision ID: 76767c77f766
Revises: 198225b21b86
Create Date: 2020-06-21 23:00:02.039493

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '76767c77f766'
down_revision = '198225b21b86'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('bookmarks',
    sa.Column('bookmarkId', sa.Integer(), nullable=False),
    sa.Column('image', sa.String(length=255), nullable=True),
    sa.Column('name', sa.String(length=255), nullable=True),
    sa.Column('author', sa.String(length=255), nullable=True),
    sa.Column('imageAuthor', sa.String(length=255), nullable=True),
    sa.Column('writingGenre', sa.String(length=255), nullable=True),
    sa.Column('achievements', sa.String(length=255), nullable=True),
    sa.Column('evaluateAuthor', sa.Float(), nullable=True),
    sa.Column('evaluateBook', sa.Float(), nullable=True),
    sa.Column('description', sa.String(length=255), nullable=True),
    sa.Column('category', sa.String(length=255), nullable=True),
    sa.Column('pages', sa.Integer(), nullable=True),
    sa.Column('cover', sa.String(length=255), nullable=True),
    sa.Column('language', sa.String(length=255), nullable=True),
    sa.Column('cost', sa.Float(), nullable=True),
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
    op.create_table('members',
    sa.Column('memberId', sa.Integer(), nullable=False),
    sa.Column('username', sa.String(length=255), nullable=True),
    sa.Column('password', sa.String(length=255), nullable=True),
    sa.Column('name', sa.String(length=255), nullable=True),
    sa.Column('email', sa.String(length=255), nullable=True),
    sa.Column('address', sa.String(length=255), nullable=True),
    sa.Column('admin', sa.Boolean(), nullable=True),
    sa.PrimaryKeyConstraint('memberId')
    )
    op.create_table('payments',
    sa.Column('paymentId', sa.Integer(), nullable=False),
    sa.Column('image', sa.String(length=255), nullable=True),
    sa.Column('name', sa.String(length=255), nullable=True),
    sa.Column('author', sa.String(length=255), nullable=True),
    sa.Column('evaluateBook', sa.Float(), nullable=True),
    sa.Column('registrationDate', sa.BigInteger(), nullable=True),
    sa.Column('expirationDate', sa.BigInteger(), nullable=True),
    sa.Column('count', sa.Integer(), nullable=True),
    sa.Column('cost', sa.Float(), nullable=True),
    sa.Column('status', sa.Integer(), nullable=True),
    sa.Column('username', sa.String(length=255), nullable=True),
    sa.PrimaryKeyConstraint('paymentId')
    )
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('payments')
    op.drop_table('members')
    op.drop_table('carts')
    op.drop_table('bookmarks')
    # ### end Alembic commands ###
