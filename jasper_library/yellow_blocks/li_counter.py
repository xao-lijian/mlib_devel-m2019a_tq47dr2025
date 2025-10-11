from .yellow_block import YellowBlock
from .yellow_block_typecodes import *

class li_counter(YellowBlock):
    def initialize(self):
        '''
        This function is called by YellowBlocks __init__ method.
        We could override __init__ here, but this seems a little
        bit more user friendly.
        '''
        self.module = 'li_counter'
        self.add_source('li_test/li_counter.v')
        #self.add_source('pfb_20p_pack/adc_data_transform/*.xci')
        
    def modify_top(self,top):
            inst = top.get_instance(entity=self.module, name=self.fullname)

            inst.add_port('clk_in',  signal='user_clk', parent_sig=False, parent_port=False)
            inst.add_port('enable', signal='%s_enable'%self.fullname)
            inst.add_port('reset', signal='%s_reset'%self.fullname)
            #inst.add_port('data_in2', signal='%s_data_in2'%self.fullname, width=160)

            #inst.add_port('clk_out', signal='%s_clk_out'%self.fullname)
            #inst.add_port('data_valid_out', signal='%s_data_valid_out'%self.fullname)     
            inst.add_port('count', signal='%s_count'%self.fullname, width=32)
            #inst.add_port('data_out2', signal='%s_data_out2'%self.fullname, width=320)

