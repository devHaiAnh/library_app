"""empty message

Revision ID: ed56200aa422
Revises: 5c3b956a714c
Create Date: 2020-05-26 15:07:28.193474

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'ed56200aa422'
down_revision = '5c3b956a714c'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('books',
    sa.Column('bookId', sa.Integer(), nullable=False),
    sa.Column('image', sa.String(length=255), nullable=True),
    sa.Column('name', sa.String(length=255), nullable=True),
    sa.Column('author', sa.String(length=255), nullable=True),
    sa.Column('evaluate', sa.Float(), nullable=True),
    sa.Column('description', sa.String(length=255), nullable=True),
    sa.Column('category', sa.String(length=255), nullable=True),
    sa.Column('pages', sa.Integer(), nullable=True),
    sa.Column('cover', sa.String(length=255), nullable=True),
    sa.Column('language', sa.String(length=255), nullable=True),
    sa.Column('cost', sa.Float(), nullable=True),
    sa.PrimaryKeyConstraint('bookId')
    )
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('books')
    # ### end Alembic commands ###
